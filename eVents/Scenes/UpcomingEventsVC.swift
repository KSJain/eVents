//
//  UpcomingEventsVC.swift
//  eVents
//
//  Created by Kartikeya Saxena Jain on 6/24/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//

import UIKit

fileprivate typealias EventDataSource   = UITableViewDiffableDataSource<String, EventViewModel>
fileprivate typealias EventSnapshot     = NSDiffableDataSourceSnapshot<String, EventViewModel>

class UpcomingEventsVC: UIViewController {
    
    private var diffableDataSource: EventDataSource?
    private var snapshot: EventSnapshot?
    private var tableView = UITableView()
    
    var events: [EventViewModel] = [] {
        didSet {
            groupedEvents = events.reduce([:], { (groups, event) -> [String: [EventViewModel]] in
                var newGroup        = groups
                let tagGroup        = !event.tag.isEmpty ? event.tag : "No Group"
                newGroup[tagGroup]  = (groups[tagGroup] ?? []) + [event]
                return newGroup
            })
        }
    }
    
    private var groupedEvents: [String: [EventViewModel]] = [:] {
        didSet {
            var tempDict            = [String: [EventViewModel]]()
            
            for val in groupedEvents {
                let events          = val.value.sorted(by: { $0.startTimeStamp < $1.startTimeStamp })
                markConflictingEvents(events)
                tempDict[val.key]   = events
            }
            
            groupedEvents = tempDict
            createSnapshot(for: groupedEvents)
        }
    }
    
    override func viewDidLoad() {
        configureDatasource()
        configureTableView()
        configureView()
        getEvents()
    }
    
    private func configureView(){
        view.backgroundColor = .systemBlue
    }
    
}

// MARK:- Table View Delegate
extension UpcomingEventsVC: UITableViewDelegate {
    
    private func configureTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
            
        tableView.delegate              = self
        tableView.frame                 = view.bounds
        tableView.rowHeight             = view.bounds.height / 6.8
            
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionTag          = groupedEvents.keys.sorted()[section]
        let sectionTitle        = groupedEvents[sectionTag]?.first?.startDate ?? "No Date"
        
        let label               = UILabel()
        label.font              = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.backgroundColor   = .systemGray5
        label.text              = sectionTitle
        
        return label
    }
}

// MARK:- Diffable Data Source
extension UpcomingEventsVC {
    
    private func configureDatasource() {
        diffableDataSource       = EventDataSource(tableView: tableView,
                                            cellProvider: { (tableView, indexPath, event) -> UITableViewCell? in
                                                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                                                cell.textLabel?.text = event.title + (event.conflict ? " Conflicts" : " No Conflict")
                                                return cell
        })
    }
    
    private func createSnapshot(for groupedEvents: [String: [EventViewModel]]) {
        guard let diffableDataSource    = diffableDataSource else { return }
        var snapshot                    = EventSnapshot()
        let sections                    = groupedEvents.keys.sorted()
        snapshot.appendSections(sections)
        
        for section in sections  {
            if let group                = groupedEvents[section] {
                snapshot.appendItems(group, toSection: section)
            }
        }
        
        diffableDataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK:- Event Data Manipulation
extension UpcomingEventsVC {
    private func getEvents(){
        MockDataManager.shared.getEvents(for: "mock.json") { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let events):
                let viewModels          = events.map{ EventViewModel(event: $0) }
                self.events             = viewModels
            case .failure(let error):
                print("Error \(error.rawValue)")
            }
        }
    }
    
    private func markConflictingEvents(_ events: [EventViewModel]) {
        let conflictingEvent            = ConflictManager.shared.findConflict(events: events)
        ConflictManager.shared.markConflicts(for: conflictingEvent)
    }
}

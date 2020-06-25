//
//  UpcomingEventsVC.swift
//  eVents
//
//  Created by Kartikeya Saxena Jain on 6/24/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//

import UIKit

class UpcomingEventsVC: UIViewController {
    
    var events: [EventViewModel] = [] {
        didSet {
            events = events.sorted(by: { $0.startTimeStamp < $1.startTimeStamp })
        }
    }
    
    override func viewDidLoad() {
        configureView()
        getEvents()
        markConflictingEvents()
        
        for event in events {
            print(event)
        }
    }
    
    private func configureView(){
        view.backgroundColor = .systemBlue
    }
    
    private func getEvents(){
        MockDataManager.shared.getEvents(for: "mock.json") { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let events):
                let viewModels = events.map{ EventViewModel(event: $0) }
                self.events = viewModels
            case .failure(let error):
                print("Error \(error.rawValue)")
            }
        }
    }
    
    private func markConflictingEvents() {
        let conflictingEvent = ConflictManager.shared.findConflict(events: events)
        ConflictManager.shared.markConflicts(for: conflictingEvent)
    }
}

//
//  UpcomingEventsVC.swift
//  eVents
//
//  Created by Kartikeya Saxena Jain on 6/24/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//

import UIKit

class UpcomingEventsVC: UIViewController {
    
    var events = [Event]()
    
    override func viewDidLoad() {
        configureView()
        getEvents()
    }
    
    private func configureView(){
        view.backgroundColor = .systemBlue
    }
        
    private func getEvents(){
        MockDataManager.shared.getEvents(for: "mock.json") { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let events):
                self.events = events
                print("Event Count \(events.count)")
                for event in events {
                    print(event)
                }
            case .failure(let error):
                print("Error \(error.rawValue)")
            }
        }
    }
}

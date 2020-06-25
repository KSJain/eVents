//
//  ConflictManagerTest.swift
//  eVentsTests
//
//  Created by Kartikeya Saxena Jain on 6/24/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//

import XCTest

class ConflictManagerTest: XCTestCase {
    var event1 = Event(title: "Bicycling with Friends",
                       start: "November 1, 2018 6:00 AM",
                       end: "November 1, 2018 9:30 AM")
    
    var event2 = Event(title: "Yoga",
                       start: "November 1, 2018 6:00 PM",
                       end: "November 1, 2018 7:33 PM")
    
    var event3 = Event(title: "Local Pub with Friends",
                       start: "November 1, 2018 7:33 PM",
                       end: "November 1, 2018 11:00 PM")
    
    var allEvents: [EventViewModel]?
    
    func testConflictManager() throws {
        allEvents = [
            EventViewModel(event: event1),
            EventViewModel(event: event2),
            EventViewModel(event: event3),
        ]
        
        let conflictingEvents = ConflictManager.shared.findConflict(events: allEvents!)
        XCTAssertEqual(conflictingEvents, [])
    }
}

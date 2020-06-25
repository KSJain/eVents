//
//  ConflictManager.swift
//  eVents
//
//  Created by Kartikeya Saxena Jain on 6/24/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//

import Foundation

class ConflictManager {
    
    // MARK: - Singelton
    static var shared = ConflictManager()
    private init() {}
    
    func findConflict(events: [EventViewModel]) -> [EventViewModel]{
        guard events.count > 1 else { return [] }
        
        var conflicts       = [EventViewModel]()
        var tempConflicts   = [events[0]]
        var endTimeStamp    = events[0].endTimeStamp
        var conflict        = false
        
        for i in 1..<events.count {
            if events[i].startTimeStamp >= endTimeStamp {
                if conflict && !tempConflicts.isEmpty{
                    conflicts.append(contentsOf: tempConflicts)
                }
                
                tempConflicts = []
                conflict = false
            } else {
                conflict = true
            }
            endTimeStamp = max(endTimeStamp, events[i].endTimeStamp)
            tempConflicts.append(events[i])
        }
        
        if conflict && !tempConflicts.isEmpty {
            conflicts.append(contentsOf: tempConflicts)
        }
        
        return conflicts
    }
    
    func markConflicts(for events:[EventViewModel]) {
        for event in events {
            event.conflict = true
        }
    }
}

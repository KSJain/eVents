//
//  EventViewModel.swift
//  eVents
//
//  Created by Kartikeya Saxena Jain on 6/24/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//
import Foundation

class EventViewModel: Hashable {
    static func == (lhs: EventViewModel, rhs: EventViewModel) -> Bool {
        return lhs.title == rhs.title && lhs.startTime == rhs.startTime && lhs.endTimeStamp == rhs.endTimeStamp
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(startTime)
        hasher.combine(endTime)
    }
    
    var title: String
    var startTime: String
    var endTime: String
    
    var startTimeStamp: Int     = -1
    var endTimeStamp: Int       = -1
    
    var eventDate: Int          = -1
    var conflict: Bool          = false
    
    init(event: Event) {
        self.title      =  event.title
        self.startTime  = event.start
        self.endTime    = event.end
        
        if let startDate = startTime.convertToDate() {
            self.startTimeStamp = startDate.unixTimestamp
            self.eventDate = Int(startDate.convertToYearMonthDate()) ?? -2
        }
        
        if let endDate = endTime.convertToDate() {
            self.endTimeStamp = endDate.unixTimestamp
        }
        
    }
}

extension EventViewModel: CustomDebugStringConvertible {
    var debugDescription: String {
        let top     = "////////////////////////"
        let bottom  = "########################"
        
        return top + "\nTitle: \(title)\nStart: \(startTime)\nEnd  : \(endTime)\nStartTimeStamp: \(startTimeStamp)\nEndTimeStamp : \(endTimeStamp)\nEvent Date: \(eventDate)\nConflict: \(conflict)\n" + bottom
    }
}


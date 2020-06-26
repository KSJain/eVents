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
    
    var tag: String             = ""
    var startDate: String       = ""
    
    var startHour: String       = ""
    var endHour: String         = ""
    var conflict: Bool          = false
    var iconName: String        = "0"
    
    init(event: Event) {
        self.title              = event.title
        self.startTime          = event.start
        self.endTime            = event.end
        
        if let start = startTime.convertToDate() {
            self.startTimeStamp = start.unixTimestamp
            self.startDate      = start.convertToDateAndDay()
            self.startHour      = start.convertToHour()
            self.tag            = start.convertToTag()
            self.iconName       = start.convertToIconName()
        }
        
        if let endDate = endTime.convertToDate() {
            self.endTimeStamp   = endDate.unixTimestamp
            self.endHour        = endDate.convertToHour()
        }
        
    }
}

extension EventViewModel: CustomDebugStringConvertible {
    var debugDescription: String {
        return  "Title: \(title)\nEvent Date: \(startDate)\nStart: \(startHour)\nEnd  : \(endHour)\nConflict: \(conflict)\nTag: \(tag)\n"
    }
}


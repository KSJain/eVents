//
//  Event.swift
//  eVents
//
//  Created by Kartikeya Saxena Jain on 6/24/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//

// MARK: - Event
struct Event: Codable {
    let title: String
    let start: String
    let end: String
}

extension Event: CustomDebugStringConvertible {
    var debugDescription: String {
        let top     = "////////////////////////"
        let bottom  = "########################"
        return top + "\nTitle: \(title)\nStart: \(start)\nEnd  : \(end)\n" + bottom
    }
}

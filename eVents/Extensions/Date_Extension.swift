//
//  Date_Extension.swift
//  eVents
//
//  Created by Kartikeya Saxena Jain on 6/24/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//

import Foundation

extension Date {
    var unixTimestamp: Int {
        return Int(self.timeIntervalSince1970 * 1_000)
    }
    
    func convertToYearMonthDate() -> String {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "yyyyMMdd"
        return dateFormatter.string(from: self)
    }
    
    func convertToDateAndDay() -> String {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "E, d MMM YYYY"
        return dateFormatter.string(from: self)
    }
    
    func convertToHour() -> String {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "h:mm a"
        return dateFormatter.string(from: self)
    }
    
    func convertToTag() -> String {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "yyMMdd"
        return dateFormatter.string(from: self)
    }
}

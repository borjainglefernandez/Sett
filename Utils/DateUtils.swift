//
//  DateUtils.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/22/24.
//

import Foundation

class DateUtils {
    
    static public func isWithinOneWeek(of referenceDate: Date, comparedToDate date: Date?) -> Bool {
        if let date = date {
            let calendar = Calendar.current
            // Calculate the difference in days between the two dates
            if let differenceInDays = calendar.dateComponents([.day], from: date, to: referenceDate).day {
                // Check if the difference is within the range of 0 to 6
                return differenceInDays >= 0 && differenceInDays <= 6
            }
            // Return false if unable to calculate the difference
            return false
        }
        return false
    }

}

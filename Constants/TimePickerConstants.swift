//
//  DatePickerConstants.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 12/23/23.
//

import Foundation

struct TimePickerConstants {
    
    static let HOUR_RANGE: [Int] = Array(1...12)
    static let MINUTE_RANGE: [Int] = Array(0...60)
    static let MERIDIEM_RANGE: [String] = ["AM", "PM"]
    
    
    /// Gets the index of the hour range from a date
    ///
    /// - Parameter date: Date to get hour index from
    /// - Returns: the index of the hour from the hour range, if valid hour
    static func getHourIndex(date: Date) -> Int? {
        
        // Convert from military time
        var hour = Calendar.current.component(.hour, from: date)
        if hour > 12 {
            hour = hour - 12
        }
        
        if let hourIndex = TimePickerConstants.HOUR_RANGE.firstIndex(of: hour) {
            return hourIndex
        }
        return nil
    }
    
    /// Gets the index of the minute range from a date
    ///
    /// - Parameter date: Date to get minute index from
    /// - Returns: the index of the minute from the minute range, if valid minute
    static func getMinuteIndex(date: Date) -> Int? {
        let minute = Calendar.current.component(.minute, from: date)
        if let minuteIndex = TimePickerConstants.MINUTE_RANGE.firstIndex(of: minute) {
            return minuteIndex
        }
        return nil
    }
    
    /// Gets the index of the meridiem range from a date
    ///
    /// - Parameter date: Date to get meridiem index from
    /// - Returns: the index of the meridiem from the meridiem range
    static func getMeridiemIndex(date: Date) -> Int? {
        let hour = Calendar.current.component(.hour, from: date)
        if hour >= 12 {
            return 1
        }
        return 0
    }
    
}

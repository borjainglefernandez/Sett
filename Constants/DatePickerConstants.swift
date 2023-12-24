//
//  DatePickerConstants.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 12/23/23.
//

import Foundation

struct DatePickerConstants {
    
    static let yearRange: [Int] = Array(1900...2100)
    static let monthRange: [String] = DateFormatter().monthSymbols
    
    /// Gets the index of the year range from a date
    ///
    /// - Parameter date: Date to get year index from
    /// - Returns: the index of the year from the year range, if valid year
    static func getYearIndex(date: Date) -> Int? {
        let year = Calendar.current.component(.year, from: date)
        if let yearIndex = DatePickerConstants.yearRange.firstIndex(of: year) {
            return yearIndex
        }
        return nil
    }
    
    /// Gets the index of the month range from a date
    ///
    /// - Parameter date: Date to get month index from
    /// - Returns: the index of the month from the month range, if valid month
    static func getMonthIndex(date: Date) -> Int? {
        
        // Parse out the month string from the date (i.e. convert 12 to "December")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let monthString = dateFormatter.string(from: date)
        
        if let monthIndex = DatePickerConstants.monthRange.firstIndex(of: monthString) {
            return monthIndex
        }
        return nil
    }
    
    
    /// Gets the index of the day range form a date
    ///
    /// - Parameter date: Date to get day index from
    /// - Returns: the index of the day from the day range
    static func getDayIndex(date: Date) -> Int? {
        let day = Calendar.current.component(.day, from: date)
        return day - 1
    }
    
}

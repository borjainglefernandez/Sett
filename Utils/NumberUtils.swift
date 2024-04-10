//
//  NumberUtils.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 12/30/23.
//

import Foundation

class NumberUtils {
    
    /// Gets a string representation of a number with its sign
    ///
    /// - Parameter num: number to obtain with sign
    /// - Returns: number with its corresponding sign
    static public func getNumWithSign(for num: Int) -> String {
        if num <= 0 {
            return "\(num)"
        }
        return "+\(num)"
    }
    
    /// Removes leading zeros from a string representing a number.
    ///
    /// - Parameter numberString: The string representing the number with leading zeros.
    /// - Returns: A string with leading zeros removed.
    static public func stripLeadingZeros(from numberString: String) -> String {
        var strippedString = numberString
        
        // Remove leading zeros
        while strippedString.hasPrefix("0") && strippedString.count > 1 {
            strippedString.removeFirst()
        }
        return strippedString
    }
}

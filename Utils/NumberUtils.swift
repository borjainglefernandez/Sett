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
}

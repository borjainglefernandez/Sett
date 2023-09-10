//
//  DayOfTheWeek.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 9/8/23.
//

import Foundation

enum DayOfTheWeek: String, CaseIterable, Equatable {
    
    case sunday = "Sunday"
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"

    
    init(fromRawValue: String) {
        self = DayOfTheWeek(rawValue: fromRawValue)!
    }
    
    static func == (lhs: DayOfTheWeek, rhs: DayOfTheWeek) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

public class DayOfTheWeekWrapper: NSObject, NSSecureCoding {
    public static var supportsSecureCoding: Bool = true
    
    
    let dayOfTheWeek: DayOfTheWeek
    
    init(_ dayOfTheWeek: DayOfTheWeek) {
        self.dayOfTheWeek = dayOfTheWeek

    }
    
    required convenience public init?(coder: NSCoder) {
        guard let rawValue = coder.decodeObject(of: NSString.self, forKey: "dayOfTheWeek") as String?,
              let dayOfTheWeek = DayOfTheWeek(rawValue: rawValue) else {
            return nil
        }
        self.init(dayOfTheWeek)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(dayOfTheWeek.rawValue as NSString, forKey: "dayOfTheWeek")
    }
}

@objc(DayOfTheWeekTransformer)
final class DayOfTheWeekTransformer: NSSecureUnarchiveFromDataTransformer {

    static let name = NSValueTransformerName(rawValue: String(describing: DayOfTheWeekTransformer.self))

    override static var allowedTopLevelClasses: [AnyClass] {
        return [NSArray.self, DayOfTheWeekWrapper.self]
    }

    public static func register() {
        let transformer = DayOfTheWeekTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
    
}

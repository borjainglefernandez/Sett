//
//  ExerciseType.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/30/23.
//

import Foundation

enum ExerciseType: String {
    case dumbbell = "Dumbbell"
    case barbell = "Barbell"
    case cable = "Cable"
    
    init(fromRawValue: String) {
        self = ExerciseType(rawValue: fromRawValue) ?? .dumbbell
    }
}

public class ExerciseTypeWrapper: NSObject, NSCoding {
    
    let exerciseType: ExerciseType
    
    init(_ exerciseType: ExerciseType) {
        self.exerciseType = exerciseType
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        guard let rawValue = aDecoder.decodeObject(of: NSString.self, forKey: "exerciseType") as String?,
              let exerciseType = ExerciseType(rawValue: rawValue) else {
            return nil
        }
        self.init(exerciseType)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(exerciseType.rawValue as NSString, forKey: "exerciseType")
    }
}

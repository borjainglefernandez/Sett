//
//  ExerciseType.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/30/23.
//

import Foundation
import UIKit

enum ExerciseType: String, CaseIterable {
    
    case dumbbell = "Dumbbell"
    case barbell = "Barbell"
    case cable = "Cable"
    case machine = "Machine"
    case bodyweight = "Bodyweight"
    
    // MARK: - Init
    init(rawValue: String) {
        switch rawValue {
            case "Dumbbell": self = .dumbbell
            case "Barbell": self = .barbell
            case "Cable": self = .cable
            case "Machine": self = .machine
            case "Bodyweight": self = .bodyweight
            default: self = .dumbbell
        }
    }
    
    /// Mapping of an exercise type to its icon
    /// - Returns: The icon corresponding to the exercise type
    public func icon() -> UIImage {
        switch self {
            case .dumbbell:
                return UIImage(systemName: "dumbbell.fill")!
                
            case .barbell:
                return UIImage(systemName: "figure.strengthtraining.traditional")!

            case .cable:
                return UIImage(systemName: "figure.barre")!

            case .machine:
                return UIImage(systemName: "figure.hand.cycling")!

            case .bodyweight:
                return UIImage(systemName: "figure.strengthtraining.functional")!
        }
        
    }
}

public class ExerciseTypeWrapper: NSObject, NSSecureCoding {
    public static var supportsSecureCoding: Bool = true
    
    let exerciseType: ExerciseType
    
    init(_ exerciseType: ExerciseType) {
        self.exerciseType = exerciseType

    }
    
    required convenience public init?(coder: NSCoder) {
    
        guard let rawValue = coder.decodeObject(of: NSString.self, forKey: "exerciseType") as String? else {
            return nil
        }
        
        let exerciseType = ExerciseType(rawValue: rawValue)
        
        self.init(exerciseType)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(exerciseType.rawValue as NSString, forKey: "exerciseType")
    }
}

@objc(ExerciseTypeTransformer)
final class ExerciseTypeTransformer: NSSecureUnarchiveFromDataTransformer {

    static let name = NSValueTransformerName(rawValue: String(describing: ExerciseTypeTransformer.self))

    override static var allowedTopLevelClasses: [AnyClass] {
        return [ExerciseTypeWrapper.self]
    }

    public static func register() {
        let transformer = ExerciseTypeTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}

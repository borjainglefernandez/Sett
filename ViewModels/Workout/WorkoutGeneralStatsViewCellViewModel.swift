//
//  WorkoutGeneralStatsViewCellViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/17/23.
//

import Foundation
import UIKit

enum WorkoutGeneralStatsViewType: CaseIterable {
    case rating
    case startTime
    case bodyweight
    case netProgress
    case notes
}

final class WorkoutGeneralStatsViewCellViewModel: NSObject {
    public let weightRange = Array(1...500)
    public let workout: Workout
    private let type: WorkoutGeneralStatsViewType
    
    init(type: WorkoutGeneralStatsViewType, workout: Workout) {
        self.type = type
        self.workout = workout
    }
    
    var displayTitle: String {
        switch self.type {
        case .rating:
            return "Rating"
        case .startTime:
            return "Start Time"
        case .bodyweight:
            return "Body Weight"
        case .netProgress:
            return "Net Progress"
        case .notes:
            return "Notes..."
        }
    }
    
    var displayDivider: Bool {
        switch self.type {
        case .rating,.startTime, .bodyweight, .netProgress:
            return true
        case .notes:
            return false
        }
    }
    
    var displayContent: UIView {
        switch self.type {
        case .rating:
            return Rating(frame: .zero, viewModel: self)
        case .startTime:
            return StartTimePicker(frame: .zero, viewModel: self)
        case .bodyweight:
            return WeightPicker(frame: .zero, viewModel: self)
        case .netProgress, .notes:
            return WeightPicker(frame: .zero, viewModel: self)
        }
    }
}

extension WorkoutGeneralStatsViewCellViewModel {
    public func changeStartTime(newStartTime: Date) {
        self.workout.startTime = newStartTime
        CoreDataBase.save()
    }
    
    public func changeRating(newRating: Double) {
        self.workout.rating = newRating
        CoreDataBase.save()
    }
}


extension WorkoutGeneralStatsViewCellViewModel: UIPickerViewDataSource, UIPickerViewDelegate {

    // Implement the required data source methods
    // Number of components in the picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Number of rows in each component
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.weightRange.count
    }
    
    // Implement the delegate methods
    // Title for each row in each component
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(self.weightRange[row])"
    }
    
    // Handle the selection of a row in the picker view
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        workout.bodyweight = Float(self.weightRange[row])
        CoreDataBase.save()
    }
}

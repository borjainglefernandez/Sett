//
//  WorkoutGeneralStatsViewCellVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/17/23.
//

import Foundation
import UIKit
import CoreData

// MARK: - Type
enum WorkoutGeneralStatsViewType: CaseIterable {
    case rating
    case startTime
    case bodyweight
    case netProgress
    case notes
    
    public static func getGeneralStatsWorkoutComponents() -> [WorkoutGeneralStatsViewType] {
        return [.rating, .startTime, .bodyweight, .netProgress, .notes]
    }
    
    public static func getGeneralStatsSummaryComponents() -> [WorkoutGeneralStatsViewType] {
        return [.rating, .startTime, .bodyweight, .netProgress, .notes]
        
    }
}

final class WorkoutGeneralStatsViewCellVM: NSObject {
    public let weightRange: [Int] = Array(0...500)
    public let decimalRange: [Int] = Array(0...9)
    public let workout: Workout
    public let type: WorkoutGeneralStatsViewType

    // MARK: - Init
    init(type: WorkoutGeneralStatsViewType, workout: Workout) {
        self.type = type
        self.workout = workout
    }

    var displayTitle: String {
        switch self.type {
        case .rating:
            return "Rating"
        case .startTime:
            return "Start"
        case .bodyweight:
            return "Body Weight"
        case .netProgress:
            return "Net Progress"
        case .notes:
            if let notes = self.workout.notes {
                if notes.count > 0 {
                    return notes
                }
            }
            return "Notes..."
        }
    }

    var displayDivider: Bool {
        switch self.type {
        case .rating, .startTime, .bodyweight, .netProgress:
            return true
        case .notes:
            return false
        }
    }

    var displayContent: UIView {
        switch self.type {
        case .rating:
            return WorkoutGeneralStatsRating(frame: .zero, viewModel: self)
        case .startTime:
            return StartTimePickerView(frame: .zero, viewModel: self)
        case .bodyweight:
            return WeightPickerView(frame: .zero, viewModel: self)
        case .netProgress:
            return NetProgressView(frame: .zero, viewModel: self)
        case .notes:
            return NotesButton(frame: .zero, viewModel: self)
        }
    }
}

// MARK: - Notes View Protocol
extension WorkoutGeneralStatsViewCellVM: NotesViewProtocol {
    public func getNotes() -> String {
        return self.workout.notes ?? ""
    }

    public func getUITextViewDelegate() -> UITextViewDelegate {
        return self
    }
}

// MARK: - Picker View Delegate
extension WorkoutGeneralStatsViewCellVM: UIPickerViewDataSource, UIPickerViewDelegate {

    // Implement the required data source methods
    // Number of components in the picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }

    // Number of rows in each component
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.weightRange.count
        } else if component == 1 {
            return 1
        } else {
            return self.decimalRange.count
        }
    }

    // Implement the delegate methods
    // Title for each row in each component
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(self.weightRange[row])"
        } else if component == 1 {
            return "."
        } else {
            return "\(self.decimalRange[row])"
        }
    }

    // Handle the selection of a row in the picker view
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedNumber = self.weightRange[pickerView.selectedRow(inComponent: 0)]
        let selectedDecimal = self.decimalRange[pickerView.selectedRow(inComponent: 2)]
        let bodyweight = Float(selectedNumber) + Float(selectedDecimal) / 10.0
        workout.bodyweight = bodyweight
        CoreDataBase.save()
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 65
    }
}

// MARK: - Text View Delegate
extension WorkoutGeneralStatsViewCellVM: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        workout.notes = textView.text
        CoreDataBase.save()
    }
}

// MARK: - Actions
extension WorkoutGeneralStatsViewCellVM {
    public func changeStartTime(newStartTime: Date) {
        self.workout.startTime = newStartTime
        CoreDataBase.save()
    }

    public func changeRating(newRating: Double) {
        self.workout.rating = newRating
        CoreDataBase.save()
    }

    public func viewNotes(view: UIView) {
        if let parentViewController = view.getParentViewController(view) {
            let notesViewController = NotesViewController(viewModel: self)
            parentViewController.present(notesViewController, animated: true)
        }
    }
}

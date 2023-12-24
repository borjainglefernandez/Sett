//
//  TimePickerVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 12/23/23.
//

import Foundation
import UIKit

class TimePickerVM: NSObject {
    
    // Workout to change time of
    public let workout: Workout
    
    // Ranges for the time
    public let hourRange: [Int] = TimePickerConstants.hourRange
    public let minuteRange: [Int] = TimePickerConstants.minuteRange
    public let meridiemRange: [String] = TimePickerConstants.meridiemRange
    
    // MARK: - Init
    init(workout: Workout) {
        self.workout = workout
        super.init()
    }
    
    // MARK: - Actions
    private func selectTime(hour: Int, minute: Int, meridiem: String) {
        let date = self.workout.startTime ?? Date()
        
        // Update Time Components and retain previous date
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        dateComponents.hour = meridiem == "AM" ? hour : hour + 12
        dateComponents.minute = minute
        
        self.workout.startTime = Calendar.current.date(from: dateComponents)
        CoreDataBase.save()
    }
    
}

// MARK: - Picker View Delegate
extension TimePickerVM: UIPickerViewDataSource, UIPickerViewDelegate {

    // Number of components in the picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }

    // Number of rows in each component
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.hourRange.count
        } else if component == 1 {
            return self.minuteRange.count
        } else {
            return self.meridiemRange.count
        }
    }

    // Title for each row in each component
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(self.hourRange[row])"
        } else if component == 1 {
            // Add 0 for single digit minutes for viewability
            if row < 10 {
                return "0\(self.minuteRange[row])"
            }
            return "\(self.minuteRange[row])"
        } else {
            return "\(self.meridiemRange[row])"
        }
    }

    // Handle the selection of a row in the picker view
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let hourSelected: Int = self.hourRange[pickerView.selectedRow(inComponent: 0)]
        let minuteSelected: Int = self.minuteRange[pickerView.selectedRow(inComponent: 1)]
        let meridiemSelected: String = self.meridiemRange[pickerView.selectedRow(inComponent: 2)]
        self.selectTime(hour: hourSelected, minute: minuteSelected, meridiem: meridiemSelected)

    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch component {
            case 0:
                return 80
            case 1:
                return 80
            case 2:
                return 60
        default:
            return 0
        }
    }
}

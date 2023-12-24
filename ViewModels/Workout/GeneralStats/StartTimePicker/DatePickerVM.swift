//
//  DatePickerVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 12/23/23.
//

import Foundation
import UIKit

class DatePickerVM: NSObject {
    
    // Workout to modify date of
    public let workout: Workout
    
    // Ranges for date
    public let yearRange: [Int] = DatePickerConstants.yearRange
    public let monthRange: [String] = DatePickerConstants.monthRange
    public var dayRange: [Int] = Array(1...31)

    // Change day range when month and year change
    private func configureDayRange() {
        let calendar = Calendar.current
        let dateComponents = DateComponents(year: self.selectedYear, month: self.selectedMonth)
        let date = calendar.date(from: dateComponents)!
        let range = calendar.range(of: .day, in: .month, for: date)!
        self.dayRange = Array(range)
        
        // If selected day past range, change selected day to last available in new range
        if let lastDayInRange = self.dayRange.last, self.selectedDay > lastDayInRange {
            self.selectedDay = lastDayInRange
        }
    }
    
    // Currently selected date components
    public var selectedYear: Int = Calendar.current.component(.year, from: Date())
    public var selectedMonth: Int = 1
    public var selectedDay: Int = 1
    
    // MARK: - Init
    init(workout: Workout) {
        self.workout = workout
        super.init()
        
        self.configureSelectedDate()
        self.configureDayRange()
    }
    
    // MARK: - Configurations
    private func configureSelectedDate() {
        if let date = self.workout.startTime {
            self.selectedYear = Calendar.current.component(.year, from: date)
            self.selectedMonth = Calendar.current.component(.month, from: date)
            self.selectedDay = Calendar.current.component(.day, from: date)
        }
        
    }
    
    // MARK: - Actions
    private func selectDate() {
        let date = self.workout.startTime ?? Date()
        
        // Modify Date Components, keep time components
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        dateComponents.year = self.selectedYear
        dateComponents.month = self.selectedMonth
        dateComponents.day = self.selectedDay
        
        self.workout.startTime = Calendar.current.date(from: dateComponents)
        CoreDataBase.save()
    }
    
}

// MARK: - Picker View Delegate
extension DatePickerVM: UIPickerViewDataSource, UIPickerViewDelegate {

    // Number of components in the picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }

    // Number of rows in each component
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.yearRange.count
        } else if component == 1 {
            return self.monthRange.count
        } else {
            return self.dayRange.count
        }
    }

    // Title for each row in each component
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(self.yearRange[row])"
        } else if component == 1 {
            return "\(self.monthRange[row])"
        } else {
            return "\(self.dayRange[row])"
        }
    }

    // Handle the selection of a row in the picker view
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
            case 0:
                self.selectedYear = self.yearRange[pickerView.selectedRow(inComponent: 0)]
            case 1:
                self.selectedMonth = pickerView.selectedRow(inComponent: 1) + 1
            case 2:
                self.selectedDay = self.dayRange[pickerView.selectedRow(inComponent: 2)]
                default:
                    break
                }
        
        // Update days available based on month and year
        self.configureDayRange()
        pickerView.reloadComponent(2)
        self.selectDate()
    }

    // Width per component
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch component {
            case 0:
                return 80
            case 1:
                return 150
            case 2:
                return 50
        default:
            return 0
        }
    }
}

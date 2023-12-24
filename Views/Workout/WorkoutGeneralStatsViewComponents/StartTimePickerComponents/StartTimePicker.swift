//
//  StartTimePicker.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 12/23/23.
//

import UIKit

class StartTimePicker: UITextField {
    
    // Picker VMs
    private let datePickerVM: DatePickerVM
    private let timePickerVM: TimePickerVM
    
    // Pickers
    private let datePicker = UIPickerView()
    private let timePicker = UIPickerView()
    
    // Component for toggling between pickers
    lazy var pickerToggle: UIBarButtonItem = {
        let pickerToggle = UISegmentedControl(items: ["Date", "Time"])
        pickerToggle.selectedSegmentIndex = 0
        pickerToggle.addTarget(self, action: #selector(self.changePicker(_:)), for: .valueChanged)
        pickerToggle.translatesAutoresizingMaskIntoConstraints = false
            return UIBarButtonItem(customView: pickerToggle)
    }()
    
    // Toolbar when in a picker
    lazy var pickerToolBar: PickerToolBar = PickerToolBar(doneSelector: self.doneButtonTapped, middleComponent: self.pickerToggle)
    
    // MARK: - Init
    init(frame: CGRect = .zero, workout: Workout) {
        self.datePickerVM = DatePickerVM(workout: workout)
        self.timePickerVM = TimePickerVM(workout: workout)
        super.init(frame: frame)
        
        self.configure()
        self.configureToolBar()
        self.configureDateLabel()
        self.configureDatePicker()
        self.configureTimePicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser.")
    }
    
    // MARK: - Override
    override func caretRect(for position: UITextPosition) -> CGRect {
        // Get rid of cursor
        return CGRect.zero
    }
    
    // MARK: - Configurations
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = .label
        self.textAlignment = .center
        self.backgroundColor = .systemFill.withAlphaComponent(0.3)
        self.layer.cornerRadius = 7.5
        self.font = .systemFont(ofSize: 15, weight: .regular)
    }
    
    private func configureToolBar() {
        self.inputAccessoryView = self.pickerToolBar
        self.inputView = self.datePicker
    }
    
    private func configureDateLabel() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, HH:mm" // Use "EEEE" for the full day of the week

        let formattedString = dateFormatter.string(from: self.timePickerVM.workout.startTime ?? Date())
        self.text = formattedString
    }
    
    private func configureDatePicker() {
        self.datePicker.delegate = self.datePickerVM
        self.datePicker.dataSource = self.datePickerVM
        
        // Pre-populate picker
        if let startTime = self.datePickerVM.workout.startTime {
            
            // Select year
            if let yearIndex = DatePickerConstants.getYearIndex(date: startTime) {
                self.datePicker.selectRow(yearIndex, inComponent: 0, animated: false)
            }
            
            // Select month
            if let monthIndex = DatePickerConstants.getMonthIndex(date: startTime) {
                self.datePicker.selectRow(monthIndex, inComponent: 1, animated: false)
            }
            
            // Select day
            if let dayIndex = DatePickerConstants.getDayIndex(date: startTime) {
                self.datePicker.selectRow(dayIndex, inComponent: 2, animated: false)
            }
        }
    }
    
    private func configureTimePicker() {
        self.timePicker.delegate = self.timePickerVM
        self.timePicker.dataSource = self.timePickerVM
        
        // Pre-populate picker
        if let startTime = self.timePickerVM.workout.startTime {
            
            // Select hour
            if let hourIndex = TimePickerConstants.getHourIndex(date: startTime) {
                self.timePicker.selectRow(hourIndex, inComponent: 0, animated: false)
            }
            
            // Select minute
            if let minuteIndex = TimePickerConstants.getMinuteIndex(date: startTime) {
                self.timePicker.selectRow(minuteIndex, inComponent: 1, animated: false)
            }
            
            // Select meridiem
            if let meridiemIndex = TimePickerConstants.getMeridiemIndex(date: startTime) {
                self.timePicker.selectRow(meridiemIndex, inComponent: 2, animated: false)
            }
        }
        
    }
    
    // MARK: - Actions
    public func doneButtonTapped() {
        self.configureDateLabel()
        self.resignFirstResponder()
    }
    
    @objc func changePicker(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.inputView = self.datePicker
        } else {
            self.inputView = self.timePicker
        }
        self.reloadInputViews() // Reload input views to reflect the change
    }

}

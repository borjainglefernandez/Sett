//
//  StartTimePicker.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/17/23.
//

import UIKit

class StartTimePicker: UIDatePicker {
    
    private let viewModel: WorkoutGeneralStatsViewCellViewModel
    
    // MARK: - Init
    init(frame: CGRect, viewModel: WorkoutGeneralStatsViewCellViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        datePickerMode = .dateAndTime
        setDate(viewModel.workout.startTime!, animated: false)
        addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)

    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initializer")
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        // This function will be called whenever the user changes the date or time in the picker
        viewModel.changeStartTime(newStartTime: sender.date)
    }
}

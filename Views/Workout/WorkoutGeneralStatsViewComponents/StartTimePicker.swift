//
//  StartTimePicker.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/17/23.
//

import UIKit

final class StartTimePicker: UIDatePicker {
    
    private let viewModel: WorkoutGeneralStatsViewCellViewModel
    
    // MARK: - Init
    init(frame: CGRect, viewModel: WorkoutGeneralStatsViewCellViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.datePickerMode = .dateAndTime
        
        self.setDate(viewModel.workout.startTime!, animated: false)
        self.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)

    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initializer")
    }
    
    // MARK: Actions
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        self.viewModel.changeStartTime(newStartTime: sender.date)
    }
}

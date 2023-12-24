//
//  WeightPicker.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/16/23.
//

import UIKit

class WeightPicker: UITextField {
    
    private let viewModel: WorkoutGeneralStatsViewCellVM
    
    // Picker to change weight
    private let weightPicker = UIPickerView()
    
    // Toolbar when in a picker
    lazy var pickerToolBar: PickerToolBar = PickerToolBar(doneSelector: self.doneButtonTapped)
    
    // MARK: - Init
    init(frame: CGRect, viewModel: WorkoutGeneralStatsViewCellVM) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.configure()
        self.configureToolBar()
        self.configureWeightLabel()
        self.configureWeightPicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
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
        self.inputView = self.weightPicker
        self.inputAccessoryView = self.pickerToolBar
    }
    
    private func configureWeightLabel() {
        self.text = "\(self.viewModel.workout.bodyweight)"
    }
    
    private func configureWeightPicker() {
        self.weightPicker.delegate = self.viewModel
        self.weightPicker.dataSource = self.viewModel
        
        // Pre-populate picker with body weight
        let integerPart = Int(self.viewModel.workout.bodyweight)
        let decimalPart = Int(self.viewModel.workout.bodyweight.truncatingRemainder(dividingBy: 1) * 10)
        self.weightPicker.selectRow(integerPart, inComponent: 0, animated: false)
        self.weightPicker.selectRow(decimalPart, inComponent: 2, animated: false)
    }
    
    // MARK: - Actions
    public func doneButtonTapped() {
        self.text = "\(self.viewModel.workout.bodyweight)"
        self.resignFirstResponder()
    }
}

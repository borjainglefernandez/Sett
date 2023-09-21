//
//  WeightPicker.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/16/23.
//

import UIKit

class WeightPicker: UITextField {
    
    private let viewModel: WorkoutGeneralStatsViewCellVM
    
    private let weightPicker = UIPickerView()
    
    lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.setItems([self.spaceButton, self.doneButton], animated: false)
        return toolbar
    }()
    
    // Add space button to put done button on right side
    private let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    private let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
    
    // MARK: - Init
    init(frame: CGRect, viewModel: WorkoutGeneralStatsViewCellVM) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        self.configure()
        self.configureWeightPicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Override
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    
    // MARK: - Actions
    @objc func doneButtonTapped() {
        self.text = "\(self.viewModel.workout.bodyweight)"
        self.resignFirstResponder()
    }
    
    // MARK: - Configurations
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = .label
        self.textAlignment = .center
        self.font = .systemFont(ofSize: 17, weight: .regular)
        
        self.inputView = self.weightPicker
        self.text = "\(self.viewModel.workout.bodyweight)"
        
        self.inputAccessoryView = self.toolbar
    }
    
    private func configureWeightPicker() {
        self.weightPicker.delegate = self.viewModel
        self.weightPicker.dataSource = self.viewModel
        
        // Prepopulate picker with body weight
        let integerPart = Int(self.viewModel.workout.bodyweight)
        let decimalPart = Int((self.viewModel.workout.bodyweight.truncatingRemainder(dividingBy: 1)) * 100)
        self.weightPicker.selectRow(integerPart, inComponent: 0, animated: false)
        self.weightPicker.selectRow(decimalPart, inComponent: 2, animated: false)
    }
}

//
//  WeightPicker.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/16/23.
//

import UIKit

class WeightPicker: UITextField {

    private let viewModel: WorkoutGeneralStatsViewCellViewModel
    private let toolbar = UIToolbar()
    private let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
    private let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    private let weightPicker = UIPickerView()
    
    // MARK: - Init
    init(frame: CGRect, viewModel: WorkoutGeneralStatsViewCellViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemFill.withAlphaComponent(0.3)
        layer.cornerRadius = 5
        textColor = .label
        textAlignment = .center
        font = .systemFont(ofSize: 17, weight: .regular)
        self.toolbar.sizeToFit()

        self.toolbar.setItems([spaceButton, doneButton], animated: false)
        inputAccessoryView = toolbar
        
        
        self.weightPicker.delegate = viewModel
        self.weightPicker.dataSource = viewModel
        
       inputView = self.weightPicker
       text = "\(self.viewModel.workout.bodyweight)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initializer")
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
           return CGRect.zero
       }
    
    // MARK: - Actions
    @objc func doneButtonTapped() {
        text = "\(self.viewModel.workout.bodyweight)"
        self.resignFirstResponder()
    }
}

//
//  StartTimePicker.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/17/23.
//

import UIKit

final class StartTimePickerView: UIView {
    
    private let viewModel: WorkoutGeneralStatsViewCellVM
    
    // Picker to change start time
    lazy var startTimePicker: StartTimePicker = StartTimePicker(workout: self.viewModel.workout)
    
    // MARK: - Init
    init(frame: CGRect, viewModel: WorkoutGeneralStatsViewCellVM) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.startTimePicker)
        self.layer.cornerRadius = 7.5

        self.addConstraints()
        self.configureBackgroundColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            // TODO: Figure out way to make this relative
            self.widthAnchor.constraint(equalToConstant: 125),
            self.heightAnchor.constraint(equalToConstant: 25),
            
            self.startTimePicker.topAnchor.constraint(equalTo: self.topAnchor),
            self.startTimePicker.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.startTimePicker.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.startTimePicker.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    // MARK: - Configurations
    private func configureBackgroundColor() {
        var alphaComponent: Double = 0.3
        if self.traitCollection.userInterfaceStyle == .light {
            alphaComponent = 0.1
        }
        self.backgroundColor = .systemFill.withAlphaComponent(alphaComponent)
    }
}

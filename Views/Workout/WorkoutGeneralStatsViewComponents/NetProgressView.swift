//
//  NetProgressView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/18/23.
//

import UIKit

final class NetProgressView: UIView {
    
    // View Model
    private let viewModel: WorkoutGeneralStatsViewCellVM
    
    // Net Weight
    private let netWeightLabel: NumberLabelView = NumberLabelView(title: "Weight")
    
    // Net Reps
    private let netRepsLabel: NumberLabelView = NumberLabelView(title: "Reps")

    // MARK: - Init
    init(frame: CGRect, viewModel: WorkoutGeneralStatsViewCellVM) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.configureNetWeight()
        self.configureNetReps()
        
        self.addSubviews(self.netWeightLabel, self.netRepsLabel)
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            self.netRepsLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            self.netWeightLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.netRepsLabel.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 0.4),
            self.netWeightLabel.centerYAnchor.constraint(equalTo: self.netRepsLabel.centerYAnchor)
        ])
    }
    
    // MARK: - Configurations
    private func configureNetWeight() {
        if let netWeight = viewModel.workout.netProgress?.weight {
            self.netWeightLabel.setNumberText(text: NumberUtils.getNumWithSign(for: Int(netWeight)))
        }
    }
    
    private func configureNetReps() {
        if let netReps = viewModel.workout.netProgress?.reps {
            self.netRepsLabel.setNumberText(text: NumberUtils.getNumWithSign(for: Int(netReps)))
        }
    }
}

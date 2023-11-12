//
//  NetProgressView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/18/23.
//

import UIKit

final class NetProgressView: UIView {
    
    // Net Weight
    lazy var netWeightLabel: NumberLabelView = NumberLabelView(title: "Weight")
    
    // Net Reps
    lazy var netRepsLabel: NumberLabelView = NumberLabelView(title: "Reps")

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
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
}

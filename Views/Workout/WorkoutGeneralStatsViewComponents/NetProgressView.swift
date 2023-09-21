//
//  NetProgressView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/18/23.
//

import UIKit

final class NetProgressView: UIView {
    
    // Labels for Weight and Rep Titles
    lazy var weightLabel: UILabel = Label(title: "Weight", fontSize: 12, weight: .light)
    lazy var repsLabel: UILabel = Label(title: "Reps", fontSize: 12, weight: .light)

    // Labels for Net Weight and Net Reps
    lazy var weightContent: UILabel = Label(title: "0", fontSize: 17, weight: .bold)
    lazy var repsContent: UILabel = Label(title: "0", fontSize: 17, weight: .bold)

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubviews(repsLabel, repsContent, weightLabel, weightContent)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.repsLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            self.repsContent.topAnchor.constraint(equalTo: self.repsLabel.bottomAnchor, constant: 5),
            self.repsContent.centerXAnchor.constraint(equalTo: self.repsLabel.centerXAnchor),
            
            self.weightLabel.leftAnchor.constraint(equalTo: self.repsLabel.leftAnchor, constant: -60),
            self.weightLabel.centerYAnchor.constraint(equalTo: self.repsLabel.centerYAnchor),
            
            self.weightContent.centerYAnchor.constraint(equalTo: self.repsContent.centerYAnchor),
            self.weightContent.centerXAnchor.constraint(equalTo: self.weightLabel.centerXAnchor)
        ])
    }
}

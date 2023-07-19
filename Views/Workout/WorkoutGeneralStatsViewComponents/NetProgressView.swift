//
//  NetProgressView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/18/23.
//

import UIKit

final class NetProgressView: UIView {
    
    // Labels for Weight and Rep Titles
    private func createTitleLabel(title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.textColor = .label
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    lazy var weightLabel: UILabel = self.createTitleLabel(title: "Weight")
    lazy var repsLabel: UILabel = self.createTitleLabel(title: "Reps")
    
    // Labels for Net Weight and Net Reps
    private func createContentLabel(title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.textColor = .label
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    lazy var weightContent: UILabel = self.createContentLabel(title: "0")
    lazy var repsContent: UILabel = self.createContentLabel(title: "0")
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubviews(repsLabel, repsContent, weightLabel, weightContent)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initializer")
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

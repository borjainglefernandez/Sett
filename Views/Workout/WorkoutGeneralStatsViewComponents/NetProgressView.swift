//
//  NetProgressView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/18/23.
//

import UIKit

class NetProgressView: UIView {
    
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
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(repsLabel, repsContent, weightLabel, weightContent)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initializer")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            repsLabel.rightAnchor.constraint(equalTo: rightAnchor),
            
            repsContent.topAnchor.constraint(equalTo: repsLabel.bottomAnchor, constant: 5),
            repsContent.centerXAnchor.constraint(equalTo: repsLabel.centerXAnchor),
            
            weightLabel.leftAnchor.constraint(equalTo: repsLabel.leftAnchor, constant: -60),
            weightLabel.centerYAnchor.constraint(equalTo: repsLabel.centerYAnchor),
            
            weightContent.centerYAnchor.constraint(equalTo: repsContent.centerYAnchor),
            weightContent.centerXAnchor.constraint(equalTo: weightLabel.centerXAnchor)
        ])
    }
}

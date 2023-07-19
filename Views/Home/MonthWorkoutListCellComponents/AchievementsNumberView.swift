//
//  AchievementsNumberView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/26/23.
//

import UIKit

final class AchievementsNumberView: UIView {
    
    public var numAchievements: Int? {
        didSet {
            if let numAchievements = self.numAchievements {
                self.achievementsNumberLabel.text = String(describing: numAchievements)
            }
        }
    }
    
    // Circular container
    private let achievementsNumberContainer: UIView = {
        let achievementsNumberContainer =  UIView()
        achievementsNumberContainer.translatesAutoresizingMaskIntoConstraints = false
        achievementsNumberContainer.layer.cornerRadius = 25 / 2
        achievementsNumberContainer.layer.borderWidth = 3
        achievementsNumberContainer.layer.borderColor = UIColor.systemGray.cgColor
        achievementsNumberContainer.backgroundColor = .systemCyan
        return achievementsNumberContainer
    }()
    
    // Label for number of achievements
    private let achievementsNumberLabel: UILabel = {
        let achievementsNumberLabel = UILabel()
        achievementsNumberLabel.textColor = .label
        achievementsNumberLabel.font = .systemFont(ofSize: 14, weight: .bold)
        achievementsNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        return achievementsNumberLabel
    }()
        
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubviews(self.achievementsNumberContainer, self.achievementsNumberLabel)
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initializer")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.achievementsNumberContainer.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.achievementsNumberContainer.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.achievementsNumberContainer.topAnchor.constraint(equalTo: self.topAnchor),
            self.achievementsNumberContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
            self.achievementsNumberLabel.centerYAnchor.constraint(equalTo: self.achievementsNumberContainer.centerYAnchor),
            self.achievementsNumberLabel.centerXAnchor.constraint(equalTo: self.achievementsNumberContainer.centerXAnchor),
            
        ])
    }
}

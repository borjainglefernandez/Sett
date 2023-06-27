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
                self.achievementsNumber.text = String(describing: numAchievements)
            }
        }
    }
    
    private let achievementsNumberContainer: UIView = {
        let achievementsNumberContainer =  UIView()
        achievementsNumberContainer.translatesAutoresizingMaskIntoConstraints = false
        achievementsNumberContainer.layer.cornerRadius = 25 / 2
        achievementsNumberContainer.layer.borderWidth = 3
        achievementsNumberContainer.layer.borderColor = UIColor.systemGray.cgColor
        achievementsNumberContainer.backgroundColor = .systemCyan
        return achievementsNumberContainer
    }()
    
    private let achievementsNumber: UILabel = {
        let achievementsNumber = UILabel()
        achievementsNumber.textColor = .label
        achievementsNumber.font = .systemFont(ofSize: 14, weight: .bold)
        achievementsNumber.translatesAutoresizingMaskIntoConstraints = false
        return achievementsNumber
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(self.achievementsNumberContainer, self.achievementsNumber)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initializer")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.achievementsNumberContainer.leftAnchor.constraint(equalTo: leftAnchor),
            self.achievementsNumberContainer.rightAnchor.constraint(equalTo: rightAnchor),
            self.achievementsNumberContainer.topAnchor.constraint(equalTo: topAnchor),
            self.achievementsNumberContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            
            self.achievementsNumber.centerYAnchor.constraint(equalTo: self.achievementsNumberContainer.centerYAnchor),
            self.achievementsNumber.centerXAnchor.constraint(equalTo: self.achievementsNumberContainer.centerXAnchor),
            
        ])
    }
}

//
//  AchievementMedal.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/24/24.
//

import UIKit

class AchievementMedal: UIView {
    
    // Outer circular container
    private let outerAchievementsNumberContainer: UIView = {
        let achievementsNumberContainer =  UIView()
        achievementsNumberContainer.translatesAutoresizingMaskIntoConstraints = false
        achievementsNumberContainer.layer.borderWidth = 10
        achievementsNumberContainer.layer.borderColor = UIColor.systemGray6.cgColor
        achievementsNumberContainer.backgroundColor = .label
        return achievementsNumberContainer
    }()
    
    // Second circular container
    private let innerAchievementsNumberContainer: UIView = {
        let achievementsNumberContainer =  UIView()
        achievementsNumberContainer.translatesAutoresizingMaskIntoConstraints = false
        achievementsNumberContainer.backgroundColor = .systemCyan
        return achievementsNumberContainer
    }()
    
    // Label for the actual achievement
    public let achievementLabel: UILabel = {
        let achievementLabel = UILabel()
        achievementLabel.textColor = .label
        achievementLabel.font = .systemFont(ofSize: 36, weight: .bold)
        achievementLabel.translatesAutoresizingMaskIntoConstraints = false
        return achievementLabel
    }()
    
    // or
    
    // Icon button for the actual achievement
    public let iconButton: IconButton = IconButton(imageName: "", color: .label, fontSize: 36, fontWeight: .bold)

    // MARK: - Init
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubviews(self.outerAchievementsNumberContainer, self.innerAchievementsNumberContainer, self.iconButton, self.achievementLabel)
        
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
    
        // Make them circles
        self.outerAchievementsNumberContainer.layer.cornerRadius = self.outerAchievementsNumberContainer.bounds.width / 2
        self.innerAchievementsNumberContainer.layer.cornerRadius = self.innerAchievementsNumberContainer.bounds.width / 2
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.outerAchievementsNumberContainer.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.outerAchievementsNumberContainer.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.outerAchievementsNumberContainer.topAnchor.constraint(equalTo: self.topAnchor),
            self.outerAchievementsNumberContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.innerAchievementsNumberContainer.leftAnchor.constraint(equalTo: self.outerAchievementsNumberContainer.leftAnchor, constant: 15),
            self.innerAchievementsNumberContainer.rightAnchor.constraint(equalTo: self.outerAchievementsNumberContainer.rightAnchor, constant: -15),
            self.innerAchievementsNumberContainer.topAnchor.constraint(equalTo: self.outerAchievementsNumberContainer.topAnchor, constant: 15),
            self.innerAchievementsNumberContainer.bottomAnchor.constraint(equalTo: self.outerAchievementsNumberContainer.bottomAnchor, constant: -15),
            
            self.achievementLabel.centerYAnchor.constraint(equalTo: self.innerAchievementsNumberContainer.centerYAnchor),
            self.achievementLabel.centerXAnchor.constraint(equalTo: self.innerAchievementsNumberContainer.centerXAnchor),
            
            self.iconButton.centerYAnchor.constraint(equalTo: self.innerAchievementsNumberContainer.centerYAnchor),
            self.iconButton.centerXAnchor.constraint(equalTo: self.innerAchievementsNumberContainer.centerXAnchor)
        ])
    }
    
    // MARK: - Configurations
    public func configure(achievement: Achievement) {
        
        // We want to display icon if title is an icon image
        if UIImage(systemName: achievement.title ?? "") != nil,
           let iconImageName = achievement.title {
            self.configureIconImage(iconImageName: iconImageName)

            self.iconButton.isHidden = false
            self.achievementLabel.isHidden = true
        } else {
            achievementLabel.text = achievement.title
            self.iconButton.isHidden = true
            self.achievementLabel.isHidden = false
        }
    }
    
    public func configureIconImage(iconImageName: String) {
        let config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 72, weight: .bold))
        self.iconButton.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        let iconImage = UIImage(systemName: iconImageName)
        iconImage?.withTintColor(UIColor.label)
        self.iconButton.setImage(iconImage, for: .normal)
        self.iconButton.tintColor = UIColor.label
    }
}

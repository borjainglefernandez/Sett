//
//  AchievementsCarouselCell.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/24/24.
//

import UIKit

class AchievementsCarouselCell: UICollectionViewCell {
    static let cellIdentifier = "AchievementsCarouselCell"
    
    // Achievement Medal
    private let achievementMedal: AchievementMedal = AchievementMedal()
    
    // Sub Title Label
    private let subTitleLabel: Label = Label(title: "", fontSize: 25, weight: .heavy)
    
    // Subtitle Description Label
    private let subTitleDescriptionLabel: Label = Label(title: "", fontSize: 12, weight: .bold)

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews(self.achievementMedal, self.subTitleLabel, self.subTitleDescriptionLabel)
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported constructor")
    }
    
    // MARK: - LifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.achievementMedal.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            self.achievementMedal.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            self.achievementMedal.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            self.achievementMedal.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.subTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.subTitleLabel.topAnchor.constraint(equalTo: self.achievementMedal.bottomAnchor, constant: 15),
            
            self.subTitleDescriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.subTitleDescriptionLabel.topAnchor.constraint(equalTo: self.subTitleLabel.bottomAnchor, constant: 5)
        ])
    }
    
    // MARK: - Configurations
    public func configure(with viewModel: AchievementsCarouselCellVM) {
        self.achievementMedal.configure(achievement: viewModel.achievement)
        self.subTitleLabel.text = viewModel.achievement.subTitle
        self.subTitleDescriptionLabel.text = viewModel.achievement.subTitleDescription
    }
}

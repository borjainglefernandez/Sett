//
//  AchievementsCarouselCell.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/24/24.
//

import UIKit

class AchievementsCarouselCell: UICollectionViewCell {
    static let cellIdentifier = "AchievementsCarouselCell"
    
    private let achievementMedal: AchievementMedal = AchievementMedal()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubviews(self.achievementMedal)
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
            self.achievementMedal.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    // MARK: - Configurations
    public func configure(with viewModel: AchievementsCarouselCellVM) {
        self.achievementMedal.configure(achievement: viewModel.achievement)
    }
}

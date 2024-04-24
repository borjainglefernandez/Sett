//
//  AchievementsCarouselCell.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/24/24.
//

import UIKit

class AchievementsCarouselCell: UICollectionViewCell {
    static let cellIdentifier = "AchievementsCarouselCell"
    
    private let label: UILabel = Label(title: "oh")

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubviews(self.label)
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
            
            self.label.topAnchor.constraint(equalTo: self.topAnchor),
            self.label.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.label.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    // MARK: - Configurations
    public func configure(with viewModel: AchievementsCarouselCellVM) {
        self.label.text = viewModel.achievement.title
    }
}

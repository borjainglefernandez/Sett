//
//  AchievementsCarouselView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/24/24.
//

import UIKit

class AchievementsCarouselView: UIView {
    
    private let viewModel: AchievementsCarouselVM
    
    // Collection view of the achievements carousel
    public let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(AchievementsCarouselCell.self, forCellWithReuseIdentifier: AchievementsCarouselCell.cellIdentifier)
        collectionView.backgroundColor = .systemCyan
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    // MARK: - Init
    init(frame: CGRect = .zero, viewModel: AchievementsCarouselVM) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false

        self.viewModel.configure()
        self.viewModel.achievementsCarouselView = self
        self.setUpCollectionView()
        
        self.addSubviews(self.collectionView)
        self.addConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported intialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        // Base constraints
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: topAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            self.collectionView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
    
    // MARK: - Configurations
    private func setUpCollectionView() {
        self.collectionView.dataSource = self.viewModel
        self.collectionView.delegate = self.viewModel
    }
}

//
//  AchievementsCarouselView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/24/24.
//

import UIKit

class AchievementsCarouselView: UIView {
    
    private let viewModel: AchievementsCarouselVM
    
    // View for when there are no exercises to display
    public let emptyView: UILabel = EmptyLabel(frame: .zero, labelText: "No achievements, keep going!")
    
    // Collection view of the achievements carousel
    public let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(AchievementsCarouselCell.self, 
                                forCellWithReuseIdentifier: AchievementsCarouselCell.cellIdentifier)
        collectionView.backgroundColor = .systemCyan
        collectionView.showsHorizontalScrollIndicator = false
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
        self.showHideCollectionView()
        
        self.addSubviews(self.collectionView, self.emptyView)
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
            self.collectionView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
        
        // Base constraints
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: topAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
        
        // Full screen collection view if we have exercises
        if self.emptyView.isHidden {
            NSLayoutConstraint.activate([
                self.collectionView.heightAnchor.constraint(equalTo: self.heightAnchor)
            ])
        } else { // Smaller screen collection view if no exercises
            NSLayoutConstraint.activate([
                self.collectionView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65),
                self.emptyView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                self.emptyView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor)
            ])
        }
    }
    
    // MARK: - Configurations
    private func setUpCollectionView() {
        self.collectionView.dataSource = self.viewModel
        self.collectionView.delegate = self.viewModel
    }
    
    // MARK: - Actions
    
    // Shows or hides collection view depending on whether or not there are exercises in workout
    public func showHideCollectionView() {
        if self.viewModel.getAchievementsLength() > 0 {
            self.emptyView.isHidden = true
        } else {
            self.emptyView.isHidden = false
        }
    }
}

//
//  WorkoutExercisesView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 10/17/23.
//

import UIKit

class WorkoutExercisesView: UIView {
    
    private let viewModel: WorkoutExercisesVM

    // View for when there are no exercises to display
    public let emptyView: UILabel = EmptyLabel(frame: .zero, labelText: "No exercises in workout yet!")
    
    // Collection view of the category exercise containers
    public let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(WorkoutGeneralStatsView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "WorkoutGeneralStatsView")
        collectionView.register(WorkoutExercisesCell.self, forCellWithReuseIdentifier: WorkoutExercisesCell.cellIdentifier)
        collectionView.backgroundColor = .systemCyan
        collectionView.isHidden = true
        return collectionView
    }()

    // MARK: - Init
    init(frame: CGRect, viewModel: WorkoutExercisesVM) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        self.backgroundColor = .systemCyan
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.viewModel.configure()
        self.viewModel.workoutExercisesView = self
        self.setUpCollectionView()
        self.showHideCollectionView()
        
        self.addSubviews(self.collectionView, self.emptyView)
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: topAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            self.emptyView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.emptyView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    // MARK: - Configurations
    private func setUpCollectionView() {
        self.collectionView.dataSource = self.viewModel
        self.collectionView.delegate = self.viewModel
    }
    
    // MARK: - Actions
    
    // Shows or hides collection view depending on whether or not there are exercises in workout
    public func showHideCollectionView() {
        if self.viewModel.getWorkoutExercisesLength() > 0 {
            self.collectionView.isHidden = false
            self.emptyView.isHidden = true
        } else {
            self.collectionView.isHidden = true
            self.emptyView.isHidden = false
        }
    }

}

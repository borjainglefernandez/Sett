//
//  WorkoutExercisesView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 10/17/23.
//

import UIKit

class WorkoutExercisesView: UIView {
    
    private var showNoExercisesView: (() -> Void)?
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
    
    public func setShowNoExercisesText(showNoExercisesView: @escaping (() -> Void)) {
        self.showNoExercisesView = showNoExercisesView
        if let showNoExercisesView = self.showNoExercisesView {
            showNoExercisesView()
        }
    }
    
    // MARK: - Constraints
    private func addConstraints() {
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
        if self.viewModel.getWorkoutExercisesLength() > 0 {
            self.emptyView.isHidden = true
        } else {
            self.emptyView.isHidden = false
        }
    }

}

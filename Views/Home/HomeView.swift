//
//  HomeView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/16/23.
//

import UIKit

protocol WorkoutsDelegate: NSObjectProtocol {
    /// Add Workout
    ///
    /// - Parameter collectionView: The collection view to update after adding workout
    func addWorkout(collectionView: UICollectionView)
}

final class HomeView: UIView {
    
    private let workoutSortByVM: WorkoutSortByVM
    lazy var workoutsByDateVM = WorkoutsByDateVM(workoutSortByVM: self.workoutSortByVM)
    let workoutsListVM: WorkoutListVM

    // Delegate to call to add workout
    weak var delegate: WorkoutsDelegate?
    
    // View for when there are no workouts to display
    public let emptyView: UILabel = EmptyLabel(frame: .zero, labelText: "No workouts completed yet!")
    
    // Collection view of the month workout containers
    public let workoutsByMonthCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MonthListCell.self, forCellWithReuseIdentifier: MonthListCell.cellIdentifier)
        collectionView.backgroundColor = .systemCyan
        collectionView.isHidden = true
        return collectionView
    }()
    
    // Sort by workout container view if we are sorting
    private let sortByWorkoutContainerView: SortByWorkoutListContainerView
    
    // MARK: - Init
    init(frame: CGRect, workoutSortByVM: WorkoutSortByVM) {
        self.workoutSortByVM = workoutSortByVM
        self.workoutsListVM = WorkoutListVM(workoutSortByVM: workoutSortByVM)
        self.sortByWorkoutContainerView = SortByWorkoutListContainerView( workoutListVM: self.workoutsListVM)
        super.init(frame: frame)
        
        self.backgroundColor = .systemCyan
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if workoutSortByVM.workoutSortByType == .date {
            self.workoutsByDateVM.configure()
            self.setUpDelegate()
            self.setUpWorkoutsByMonthCollectionView()
            self.showHideMonthWorkoutsByMonthCollectionView()
            self.addSubviews(self.workoutsByMonthCollectionView, emptyView)
            self.addConstraintsWorkoutsByMonth()
        } else {
            self.addSubviews(self.sortByWorkoutContainerView, emptyView)
            self.addConstraintsWorkoutsByX()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraintsWorkoutsByMonth() {
        NSLayoutConstraint.activate([
            self.workoutsByMonthCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            self.workoutsByMonthCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.workoutsByMonthCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.workoutsByMonthCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.emptyView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.emptyView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func addConstraintsWorkoutsByX() {
        NSLayoutConstraint.activate([
            self.sortByWorkoutContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.sortByWorkoutContainerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.sortByWorkoutContainerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.95),
            self.sortByWorkoutContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -60),
            
            self.emptyView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.emptyView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    // MARK: - Configurations
    private func setUpDelegate() {
        self.delegate = self.workoutsByDateVM
    }
    
    private func setUpWorkoutsByMonthCollectionView() {
        self.workoutsByMonthCollectionView.dataSource = self.workoutsByDateVM
        self.workoutsByMonthCollectionView.delegate = self.workoutsByDateVM
        self.workoutsByDateVM.homeView = self
    }
    
    // Shows or hides collection view depending on whether or not there are workouts
    public func showHideMonthWorkoutsByMonthCollectionView() {
        if self.workoutsByDateVM.getWorkoutsLength() > 0 {
            self.workoutsByMonthCollectionView.isHidden = false
            self.emptyView.isHidden = true
        } else {
            self.workoutsByMonthCollectionView.isHidden = true
            self.emptyView.isHidden = false
        }
    }
}

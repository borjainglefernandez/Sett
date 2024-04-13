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
    
    let workoutsByDateVM = WorkoutsByDateVM()
    
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
    
    // Table View for workouts sorted by something other than date
    private let workoutsTableView: UITableView = {
        let workoutsTableView = UITableView()
        workoutsTableView.backgroundColor = .systemGray3.withAlphaComponent(0.44)
        workoutsTableView.translatesAutoresizingMaskIntoConstraints = false
        workoutsTableView.register( WorkoutListCell.self, forCellReuseIdentifier: WorkoutListCell.cellIdentifier)
        workoutsTableView.layer.cornerRadius = 15
        workoutsTableView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        workoutsTableView.isScrollEnabled = false
        workoutsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return workoutsTableView
    }()
    
    // MARK: - Init
    init(frame: CGRect, workoutSortByType: WorkoutSortByType) {
        super.init(frame: frame)
        
        self.backgroundColor = .systemCyan
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if workoutSortByType == .date {
            self.workoutsByDateVM.configure()
            self.setUpDelegate()
            self.setUpWorkoutsByMonthCollectionView()
            self.showHideMonthWorkoutsByMonthCollectionView()
        } else {
            
        }
        self.addSubviews(self.workoutsByMonthCollectionView, emptyView)
        self.addConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.workoutsByMonthCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            self.workoutsByMonthCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.workoutsByMonthCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.workoutsByMonthCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
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

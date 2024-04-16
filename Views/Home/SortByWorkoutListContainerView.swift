//
//  SortByWorkoutListContainerView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/15/24.
//

import UIKit

class SortByWorkoutListContainerView: UIView {
    
    private let topBar: UIView = MenuBar(frame: .zero, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
    private let workoutListVM: WorkoutListVM
    lazy var titleLabel: UILabel = Label(frame: .zero, title: "Sort by \(self.workoutListVM.workoutSortByVM.workoutSortByType)", fontSize: 14.0)
    
    private let workoutListView: WorkoutListView = WorkoutListView()
    
    // Empty view if no workouts
    public let emptyView: UILabel = EmptyLabel(frame: .zero, labelText: "No workouts completed yet!")

    // MARK: - Init
    init(workoutListVM: WorkoutListVM) {
        self.workoutListVM = workoutListVM
        super.init(frame: .zero)
        
        self.workoutListVM.sortByWorkoutContainerView = self
        self.workoutListView.configure(with: workoutListVM)
        self.showHideTableView()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubviews(self.topBar, self.titleLabel, self.workoutListView, self.emptyView)
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.topBar.topAnchor.constraint(equalTo: self.topAnchor),
            self.topBar.heightAnchor.constraint(equalToConstant: 30),
            self.topBar.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.topBar.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            self.titleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 2),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            
            self.workoutListView.topAnchor.constraint(equalTo: self.topBar.bottomAnchor),
            self.workoutListView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.workoutListView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.workoutListView.leftAnchor.constraint(equalTo: self.leftAnchor),
            
            self.emptyView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.emptyView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    // Shows or hides table view depending on whether or not there are workouts
    public func showHideTableView() {
        let showTableView = self.workoutListVM.getNumberOfWorkouts() > 0
        self.topBar.isHidden = !showTableView
        self.titleLabel.isHidden = !showTableView
        self.workoutListView.isHidden = !showTableView
        self.emptyView.isHidden = showTableView
    }
}

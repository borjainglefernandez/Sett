//
//  SortByWorkoutListContainerView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/15/24.
//

import UIKit

class SortByWorkoutListContainerView: UIView {
    
    private let topBar: UIView = MenuBar(frame: .zero, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
    lazy var titleLabel: UILabel = Label(frame: .zero, title: "YOOOO", fontSize: 14.0)
    
    // Workout list view for if we are sort
    private let workoutListView: WorkoutListView = WorkoutListView()
    
    // MARK: - Init
    init(workoutListVM: WorkoutListVM) {
        self.workoutListView.configure(with: workoutListVM)
        super.init(frame: .zero)

        self.translatesAutoresizingMaskIntoConstraints = false

        self.addSubviews(self.topBar, self.titleLabel, self.workoutListView)
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.topBar.heightAnchor.constraint(equalToConstant: 30),
            self.topBar.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.topBar.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            self.titleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 2),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            
            self.workoutListView.topAnchor.constraint(equalTo: self.topBar.bottomAnchor),
            self.workoutListView.heightAnchor.constraint(equalTo: self.heightAnchor),
            self.workoutListView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.workoutListView.leftAnchor.constraint(equalTo: self.leftAnchor)
        ])
    }
}

//
//  WorkoutBottomBarView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 3/5/24.
//

import UIKit

class WorkoutBottomBarView: UIView {
    
    private let viewModel: WorkoutBottomBarVM
    
    lazy var dateLabel: UILabel = Label(title: self.viewModel.getWorkoutDateFormatted(),
                                        fontSize: 12,
                                        weight: .regular)
    
    lazy var workoutTimer: WorkoutTimer = {
        let workoutTimer = WorkoutTimer()
        return workoutTimer
    }()
    
    // MARK: - Init
    init(frame: CGRect, viewModel: WorkoutBottomBarVM) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.layer.cornerRadius = 15
        self.backgroundColor = .systemGray4
        
        self.addSubviews(self.dateLabel, self.workoutTimer)
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.dateLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 2),
            self.dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            self.workoutTimer.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.workoutTimer.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}

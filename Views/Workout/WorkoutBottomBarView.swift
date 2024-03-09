//
//  WorkoutBottomBarView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 3/5/24.
//

import UIKit

class WorkoutBottomBarView: UIView {
    
    private let viewModel: WorkoutBottomBarVM
    
    private let pauseIconButton = IconButton(imageName: "pause.circle.fill")
    private let resumeIconButton = IconButton(imageName: "play.circle.fill")

    lazy var workoutTimer: WorkoutTimer = {
        let workoutTimer = WorkoutTimer(viewModel: self.viewModel)
        return workoutTimer
    }()
    
    private let completeWorkoutIconButton = IconButton(imageName: "checkmark.circle.fill")
    
    // MARK: - Init
    init(frame: CGRect, viewModel: WorkoutBottomBarVM) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 15
        self.backgroundColor = .systemGray4
        
        self.pauseIconButton.addTarget(self, action: #selector(self.pauseWorkout), for: .touchUpInside)
        self.resumeIconButton.addTarget(self, action: #selector(self.resumeWorkout), for: .touchUpInside)
        self.completeWorkoutIconButton.addTarget(self, action: #selector(self.completeWorkout), for: .touchUpInside)

        self.addSubviews(self.pauseIconButton, self.resumeIconButton, self.workoutTimer, self.completeWorkoutIconButton)
        self.showHidePlayPause()
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.pauseIconButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 7),
            self.pauseIconButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            self.resumeIconButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 7),
            self.resumeIconButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            self.workoutTimer.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.workoutTimer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.completeWorkoutIconButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -7),
            self.completeWorkoutIconButton.centerYAnchor.constraint(equalTo: self.pauseIconButton.centerYAnchor)
        ])
    }
    
    // MARK: - Configurations
    private func showHidePlayPause() {
        self.resumeIconButton.isHidden = self.viewModel.isOngoingWorkout()
        self.pauseIconButton.isHidden = !self.viewModel.isOngoingWorkout()
    }
    
    // MARK: - Actions
    @objc func pauseWorkout() {
        self.workoutTimer.stopTime()
        self.showHidePlayPause()
    }
    
    @objc func resumeWorkout() {
        self.viewModel.resumeWorkout()
        self.workoutTimer.initialiseTimer()
        self.showHidePlayPause()
    }
    
    @objc func completeWorkout() {
        self.workoutTimer.stopTime()
        self.showHidePlayPause()
    }
    
}

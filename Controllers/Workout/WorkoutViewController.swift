//
//  WorkoutViewController.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/14/23.
//

import UIKit
import SwiftUI

final class WorkoutViewController: UIViewController {
    private let workout: Workout
    
    private let topBar: MenuBar = MenuBar(frame: .zero)
    private let backButton: UIButton = IconButton(frame: .zero, imageName: "arrow.backward.circle.fill")
    private let moreButton: UIButton = IconButton(frame: .zero, imageName: "ellipsis.circle.fill")

    lazy var workoutName: UITextField = {
        let workoutName = UITextField()
        workoutName.textColor = .label
        workoutName.font = .systemFont(ofSize: 17, weight: .bold)
        workoutName.translatesAutoresizingMaskIntoConstraints = false
        workoutName.text = self.generalStatsVM.workout.title
        workoutName.delegate = self.generalStatsVM
        return workoutName
    }()
    
    private let generalStatsVM: WorkoutGeneralStatsVM
    
    private let workoutExercisesView: WorkoutExercisesView
    
    private let workoutBottomBarView: WorkoutBottomBarView

    // MARK: - Init
    init(workout: Workout) {
        self.workout = workout
        
        self.generalStatsVM = WorkoutGeneralStatsVM(workout: workout)
        
        let workoutExercisesVM = WorkoutExercisesVM(workout: workout)
        self.workoutExercisesView = WorkoutExercisesView(frame: .zero, viewModel: workoutExercisesVM)
        
        let workoutBottomBarVM = WorkoutBottomBarVM(workout: workout)
        self.workoutBottomBarView = WorkoutBottomBarView(frame: .zero, viewModel: workoutBottomBarVM)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardWhenTapOutside()
        
        self.view.backgroundColor = .systemCyan
        
        self.topBar.addSubviews(self.backButton, self.workoutName, self.moreButton)
        self.view.addSubviews(self.topBar, self.workoutExercisesView, self.workoutBottomBarView)
        self.addConstraints()
        
        self.backButton.addTarget(self, action: #selector(self.goBack), for: .touchUpInside)

        self.moreButton.showsMenuAsPrimaryAction = true
//        self.moreButton.menu = UIMenu(preferredElementSize: .small, children: [AddExerciseMenuItem()])
        self.moreButton.menu = OverallWorkoutMenu(workout: self.workout, overallView: self.view).getMenu()
    }

    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.topBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.topBar.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.topBar.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.95),
            
            self.backButton.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            self.backButton.leftAnchor.constraint(equalTo: self.topBar.leftAnchor, constant: 7),
            
            self.workoutName.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            self.workoutName.centerXAnchor.constraint(equalTo: self.topBar.centerXAnchor),
            
            self.moreButton.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            self.moreButton.rightAnchor.constraint(equalTo: self.topBar.rightAnchor, constant: -7),
            
            self.workoutExercisesView.topAnchor.constraint(equalTo: self.topBar.bottomAnchor, constant: 7),
            self.workoutExercisesView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.workoutExercisesView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            self.workoutExercisesView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.90),
            
            self.workoutBottomBarView.topAnchor.constraint(equalTo: self.workoutExercisesView.bottomAnchor, constant: 7),
            self.workoutBottomBarView.centerXAnchor.constraint(equalTo: self.topBar.centerXAnchor),
            self.workoutBottomBarView.widthAnchor.constraint(equalTo: self.topBar.widthAnchor),
            self.workoutBottomBarView.heightAnchor.constraint(equalTo: self.topBar.heightAnchor)
            
            //            self.workoutExercisesView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    // MARK: - Actions
    @objc func goBack() {
        self.dismiss(animated: true)
    }

}

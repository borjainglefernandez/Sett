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
    
    private let generalStatsVM: WorkoutGeneralStatsVM
    private let workoutGeneralStatsView: WorkoutGeneralStatsView
    
    private let workoutExercisesVM: WorkoutExercisesVM
    private let workoutExercisesView: WorkoutExercisesView
    
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

    // MARK: - Init
    init(workout: Workout) {
        self.workout = workout
        
        self.generalStatsVM = WorkoutGeneralStatsVM(workout: workout)
        self.workoutGeneralStatsView = WorkoutGeneralStatsView(frame: .zero, viewModel: self.generalStatsVM)
        
        self.workoutExercisesVM = WorkoutExercisesVM(workout: workout)
        self.workoutExercisesView = WorkoutExercisesView(frame: .zero, viewModel: self.workoutExercisesVM)
        
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
        self.view.addSubviews(self.topBar, self.workoutGeneralStatsView, self.workoutExercisesView)
        self.addConstraints()
        
        self.backButton.addTarget(self, action: #selector(self.goBack), for: .touchUpInside)
        self.moreButton.addTarget(self, action: #selector(self.addExercise), for: .touchUpInside)
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
            
            self.workoutGeneralStatsView.topAnchor.constraint(equalTo: self.topBar.bottomAnchor),
            self.workoutGeneralStatsView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.workoutGeneralStatsView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            self.workoutGeneralStatsView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
            
            self.workoutExercisesView.topAnchor.constraint(equalTo: self.workoutGeneralStatsView.bottomAnchor, constant: 7),
            self.workoutExercisesView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.workoutExercisesView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            self.workoutExercisesView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    // MARK: - Actions
    @objc func goBack() {
        self.dismiss(animated: true)
    }
    
    // TODO: Get rid of later
    @objc func addExercise() {
        let workoutExercises = CoreDataBase.fetchEntities(withEntity: "WorkoutExercise", expecting: WorkoutExercise.self)
        guard let workoutExerciseTemplate = workoutExercises?.last else {
            return
        }

        let workoutExercise = WorkoutExercise(context: CoreDataBase.context)
        workoutExercise.numSetts = 4
        workoutExercise.exercise = workoutExerciseTemplate.exercise
        
        let settCollection = SettCollection(context: CoreDataBase.context)
        for _ in 1...workoutExercise.numSetts {
            let sett = Sett(context: CoreDataBase.context)
            settCollection.addToSetts(sett)
        }
        settCollection.workoutExercise = workoutExercise
        settCollection.exercise = workoutExercise.exercise
        workoutExercise.settCollection = settCollection
        self.workout.addToWorkoutExercises(workoutExercise)
        CoreDataBase.save()
    }
}

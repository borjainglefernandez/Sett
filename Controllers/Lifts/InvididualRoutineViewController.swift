//
//  RoutineViewController.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/28/23.
//

import UIKit

class IndividualRoutineViewController: UIViewController {
    private let viewModel: IndividualRoutineVM
    
    private let topBar: MenuBar = MenuBar(frame: .zero)
    private let backButton: UIButton = IconButton(frame: .zero, imageName: "arrow.backward.circle.fill")
    private let startRoutineButton: UIButton = IconButton(frame: .zero, imageName: "play.circle")
    private let moreButton: UIButton = IconButton(frame: .zero, imageName: "ellipsis.circle.fill")

    lazy var routineName: UITextField = {
        let routineName = UITextField()
        routineName.textColor = .label
        routineName.font = .systemFont(ofSize: 17, weight: .bold)
        routineName.translatesAutoresizingMaskIntoConstraints = false
        routineName.text = self.viewModel.routine.name
        routineName.delegate = self.viewModel
        return routineName
    }()
    
    private let routineExerciseList: RoutineExerciseList
    
    // MARK: - Init
    init(viewModel: IndividualRoutineVM) {
        self.viewModel = viewModel
        self.routineExerciseList = RoutineExerciseList(viewModel: RoutineExerciseListVM(routine: self.viewModel.routine))
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardWhenTapOutside()
        
        self.view.backgroundColor = .systemCyan
        
        self.topBar.addSubviews(self.backButton, self.routineName, self.startRoutineButton, self.moreButton)
        self.view.addSubviews(self.topBar, self.routineExerciseList)
        self.addConstraints()
        
        self.backButton.addTarget(self, action: #selector(self.goBack), for: .touchUpInside)
        self.startRoutineButton.addTarget(self, action: #selector(self.startRoutine), for: .touchUpInside)

        self.moreButton.showsMenuAsPrimaryAction = true
        self.moreButton.menu = RoutineMenu(routine: self.viewModel.routine, overallView: self.view).getMenu()
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.topBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.topBar.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.topBar.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.95),
            
            self.backButton.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            self.backButton.leftAnchor.constraint(equalTo: self.topBar.leftAnchor, constant: 7),
            
            self.routineName.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            self.routineName.centerXAnchor.constraint(equalTo: self.topBar.centerXAnchor),
            
            self.moreButton.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            self.moreButton.rightAnchor.constraint(equalTo: self.topBar.rightAnchor, constant: -7),
            
            self.startRoutineButton.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            self.startRoutineButton.rightAnchor.constraint(equalTo: self.moreButton.leftAnchor, constant: -7),
            
            self.routineExerciseList.topAnchor.constraint(equalTo: self.topBar.bottomAnchor),
            self.routineExerciseList.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.routineExerciseList.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            self.routineExerciseList.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Actions
    @objc func goBack() {
        self.dismiss(animated: true)
    }
    
    @objc func startRoutine() {
        let routine = self.viewModel.routine
        
        // Create new workout
        let newWorkout = Workout(context: CoreDataBase.context)
        newWorkout.title = routine.name
        newWorkout.startTime = Date()
        routine.addToWorkouts(newWorkout)
        
        // Add workout exercises to workout
        if let workoutExercises = routine.workoutExercises {
            for workoutExercise in workoutExercises {
                if let workoutExercise = workoutExercise as? WorkoutExercise {
                    // Configure new workout exercise
                    let newWorkoutExercise = WorkoutExercise(context: CoreDataBase.context)
                    newWorkoutExercise.exercise = workoutExercise.exercise
                    newWorkoutExercise.exerciseIndex = workoutExercise.exerciseIndex
                    newWorkoutExercise.numSetts = workoutExercise.numSetts
                    
                    let newSettCollection = SettCollection(context: CoreDataBase.context)
                    
                    // Add setts to sett collection
                    for _ in 0..<workoutExercise.numSetts {
                        let newSett = Sett(context: CoreDataBase.context)
                        newSettCollection.addToSetts(newSett)
                    }
                    
                    // Configure sett collection
                    newSettCollection.workoutExercise = newWorkoutExercise
                    newSettCollection.exercise = newWorkoutExercise.exercise
                    
                    // Add exercise to workout
                    newWorkout.addToWorkoutExercises(newWorkoutExercise)
                }
            }
        }
        let workoutViewController = WorkoutViewController(workout: newWorkout)
        workoutViewController.modalPresentationStyle = .fullScreen

        // Leave this window
        self.dismiss(animated: true)

        // Navigate to workout screen
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        if let navigationController = window.rootViewController as? UINavigationController,
           let tabBarController = navigationController.topViewController as? UITabBarController {
            // Want to be at home screen
            tabBarController.selectedIndex = 0
            tabBarController.present(workoutViewController, animated: true)
        }
    }

}

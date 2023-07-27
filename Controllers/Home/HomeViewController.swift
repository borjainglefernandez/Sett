//
//  HomeViewController.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/7/23.
//

import UIKit
import CoreData

final class HomeViewController: UIViewController {
    
    // Top bar of the home page
    private let topBar: UIView = TopBar(frame: .zero)
    
    // Title label for currently selected feed
    private let titleLabel = TitleLabel(frame: .zero, title: "Workouts")
    
    // Button to add a workout
    private let addWorkoutButton: UIButton = IconButton(frame: .zero, imageName: "plus.circle")
    
    // Button to sort workouts
    private let sortWorkoutButton: UIButton = IconButton(frame: .zero, imageName: "arrow.up.arrow.down.circle")
        
    // Home View
    private let homeView = HomeView()
    
    // Add Workout Menu
    private func setUpAddWorkoutMenu() {
        self.addWorkoutButton.showsMenuAsPrimaryAction = true
        
        let blankWorkoutButton = UIAction(title: "Blank Workout", image: UIImage(systemName: "plus.circle"), attributes: [], state: .off) { action in
            self.createBlankWorkout()
        }
        let startWorkoutButton = UIAction(title: "Start Routine", image: UIImage(systemName: "arrow.clockwise.circle"), attributes: [], state: .off) { action in
            self.startRoutine()
        }
        
        self.addWorkoutButton.menu = UIMenu(children: [blankWorkoutButton, startWorkoutButton])
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemCyan
        
        self.setUpAddWorkoutMenu()
        
        self.topBar.addSubviews(self.titleLabel, self.addWorkoutButton, self.sortWorkoutButton)
        self.view.addSubviews(self.topBar, self.homeView)
        self.addConstraints()
    }
    
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.topBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.topBar.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.topBar.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.95),
            self.topBar.heightAnchor.constraint(equalToConstant: 30),
            
            self.titleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.topBar.leftAnchor, multiplier: 2),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            
            self.sortWorkoutButton.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            self.sortWorkoutButton.rightAnchor.constraint(equalTo: self.topBar.rightAnchor, constant: -15),
            
            self.addWorkoutButton.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            self.addWorkoutButton.rightAnchor.constraint(equalTo: sortWorkoutButton.leftAnchor, constant: -7),

            self.homeView.topAnchor.constraint(equalTo: self.topBar.bottomAnchor),
            self.homeView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.homeView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            self.homeView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Actions
    private func createBlankWorkout() {
        // Create new workout
        let newWorkout = Workout(context: CoreDataBase.context)
        newWorkout.rating = 3
        newWorkout.startTime = Date()
        newWorkout.title = "New Workout"
        CoreDataBase.save()
        
        // Navigate to new workout screen
        let workoutViewModel = WorkoutViewModel(workout: newWorkout)
        let workoutViewController = WorkoutViewController(viewModel: workoutViewModel)
        workoutViewController.modalPresentationStyle = .fullScreen
        self.present(workoutViewController, animated: true)
    }
    
    private func startRoutine() {
//        if let delegate = self.delegate {
//            delegate.addWorkout(collectionView: self.collectionView)
//        }
//        
//        // Show collection view if previously hidden
//        showHideCollectionView()
        
    }
    
}


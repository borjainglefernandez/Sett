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
    private let topBar: UIView = {
        let topBar = UIView()
        topBar.translatesAutoresizingMaskIntoConstraints = false
        topBar.backgroundColor = .systemGray4
        topBar.layer.cornerRadius = 15
        return topBar
    }()
    
    // Title label for currently selected feed
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        
        titleLabel.textColor = .label
        titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
        titleLabel.text = "Workouts"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    // Button to add a workout
    private let addWorkoutButton: UIButton = {
        let addWorkoutButton = UIButton(type: .custom)
        let iconImage = UIImage(systemName: "plus.circle")
        var config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 17.0, weight: .bold))
        addWorkoutButton.tintColor = .systemCyan
        addWorkoutButton.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        addWorkoutButton.translatesAutoresizingMaskIntoConstraints = false
        addWorkoutButton.setImage(iconImage, for: .normal)
        addWorkoutButton.showsMenuAsPrimaryAction = true
        return addWorkoutButton
    }()
    
    // Button to sort workouts
    private let sortWorkoutButton: UIButton = {
        let iconButton = UIButton(type: .custom)
        let iconImage = UIImage(systemName: "arrow.up.arrow.down.circle")
        var config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 17.0, weight: .bold))
        iconButton.tintColor = .systemCyan
        iconButton.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        iconButton.translatesAutoresizingMaskIntoConstraints = false
        iconButton.setImage(iconImage, for: .normal)
        return iconButton
    }()
        
    // Home View
    private let homeView = HomeView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemCyan
        
        self.setUpAddWorkoutMenu()
        
        self.topBar.addSubviews(titleLabel, addWorkoutButton, sortWorkoutButton)
        self.view.addSubviews(topBar, homeView)
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
    
    private func setUpAddWorkoutMenu() {
        let blankWorkoutButton = UIAction(title: "Blank Workout", image: UIImage(systemName: "plus.circle"), attributes: [], state: .off) { action in
            self.createBlankWorkout()
        }
        let startWorkoutButton = UIAction(title: "Start Routine", image: UIImage(systemName: "arrow.clockwise.circle"), attributes: [], state: .off) { action in
            self.startRoutine()
        }
        
        self.addWorkoutButton.menu = UIMenu(children: [blankWorkoutButton, startWorkoutButton])
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


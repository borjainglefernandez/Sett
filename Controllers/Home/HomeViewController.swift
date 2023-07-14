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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        topBar.addSubviews(titleLabel, addWorkoutButton, sortWorkoutButton)
        view.addSubviews(topBar, homeView)
        self.addConstraints()
        setUpAddWorkoutMenu()
    }
    
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topBar.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            topBar.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.95),
            topBar.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: topBar.leftAnchor, multiplier: 2),
            titleLabel.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            
            sortWorkoutButton.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            sortWorkoutButton.rightAnchor.constraint(equalTo: topBar.rightAnchor, constant: -15),
            
            addWorkoutButton.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            addWorkoutButton.rightAnchor.constraint(equalTo: sortWorkoutButton.leftAnchor, constant: -7),

            homeView.topAnchor.constraint(equalTo: topBar.bottomAnchor),
            homeView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            homeView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
        let newWorkout = Workout(context: CoreDataBase.context)
        newWorkout.rating = 3
        newWorkout.startTime = Date()
        newWorkout.title = "New Workout"
        CoreDataBase.save()
        
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


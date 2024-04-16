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
    private let topBar: UIView = MenuBar(frame: .zero)
    
    // Title label for currently selected feed
    private let titleLabel = Label(frame: .zero, title: "Workouts")
    
    // Button to add a workout
    private let addWorkoutButton: UIButton = IconButton(frame: .zero, imageName: "plus.circle")
    
    // Button to sort workouts
    private let sortWorkoutButton: UIButton = IconButton(frame: .zero, imageName: "arrow.up.arrow.down.circle")
        
    // Workouts sort by typed default
    private var workoutSortByVM = WorkoutSortByVM(workoutSortByType: .date, ascending: false)
    
    // Home View
    lazy var homeView: HomeView = HomeView(frame: .zero, workoutSortByVM: self.workoutSortByVM)
    
    // Selected Index for sort menu
    private var sortSelectedIndex = 0
    
    // Whether or not we are in ascending order
    private var sortAscending = false
    
    // Add Workout Menu
    private func setUpAddWorkoutMenu() {
        self.addWorkoutButton.showsMenuAsPrimaryAction = true
        
        let blankWorkoutButton = UIAction(
            title: "Blank Workout",
            image: UIImage(systemName: "plus.circle"),
            attributes: [], state: .off) { _ in
                self.createBlankWorkout()
        }
        let startWorkoutButton = UIAction(
            title: "Start Routine",
            image: UIImage(systemName: "arrow.clockwise.circle"),
            attributes: [],
            state: .off) { _ in
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
        
        self.homeView = HomeView(frame: .zero, workoutSortByVM: self.workoutSortByVM)
        
        self.view.addSubviews(self.topBar, self.homeView)
        
        sortWorkoutButton.showsMenuAsPrimaryAction = true
        sortWorkoutButton.menu = SortWorkoutsMenu(
            homeViewController: self,
            workoutSortByVM: self.workoutSortByVM
        ).getMenu()
        
        self.addConstraints()
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.topBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.topBar.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.topBar.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.95),
            
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
        let workoutViewController = WorkoutViewController(workout: newWorkout)
        workoutViewController.modalPresentationStyle = .fullScreen
        self.present(workoutViewController, animated: true)
    }
    
    private func startRoutine() {
        self.tabBarController?.selectedIndex = 1
    }
}

extension HomeViewController { // Sort Menu actions
    
    public func calculateAscending(workoutSortByType: WorkoutSortByType) {
        // If we are already toggling this category of sort by,
        // then change the sort order
        if self.workoutSortByVM.workoutSortByType == workoutSortByType {
            self.sortAscending = !self.sortAscending
        } else {
            // Default is descending for new sort category
            self.sortAscending = false
        }
    }
    
    public func sortBy(workoutSortByType: WorkoutSortByType) {
        
        // If we are already toggling this category of sort by,
        // then change the sort order
        if self.workoutSortByVM.workoutSortByType == workoutSortByType {
            self.workoutSortByVM.ascending = !self.workoutSortByVM.ascending
        } else {
            // Default is descending for new sort category
            self.workoutSortByVM.ascending = false
        }
        
        self.workoutSortByVM.workoutSortByType = workoutSortByType
        
        // Reload views
        self.viewDidLoad()
    }
}

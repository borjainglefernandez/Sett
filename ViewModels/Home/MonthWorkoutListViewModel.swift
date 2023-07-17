//
//  MonthWorkoutListViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/19/23.
//

import UIKit
import CoreData

protocol DeleteWorkoutDelegate: NSObject {
    func deleteWorkout(workout: Workout, viewModel: MonthWorkoutListViewModel)
}

final class MonthWorkoutListViewModel: NSObject {
    
    public var month: Int
    public var year: Int
    public var workouts: [Workout] = []
    private var cellViewModels: [MonthWorkoutListCellViewModel] = []
    
    // MARK: - Init
    
    init(
        month: Int,
        year: Int
    ) {
        self.month = month
        self.year = year
        super.init()
        self.setWorkouts()
    }
    
    // MARK: - Actions
    
    /// Fetch and set the workouts for the month
    public func setWorkouts() {
        self.cellViewModels = []
        
        // Create start and end dates for a particular month
        let startDateComponents = DateComponents(year: self.year, month: self.month, day: 1, hour: 0, minute: 0, second: 0)
        var incrementDateComponents = DateComponents()
        incrementDateComponents.month = 1
        let calendar:Calendar = Calendar.current
        guard let startDate: Date = calendar.date(from: startDateComponents),
              let endDate: Date = calendar.date(byAdding: incrementDateComponents, to: startDate) else {
            fatalError("Dates could not be converted")
        }
        
        // Get workouts for particular month
        let predicate = NSPredicate(format: "(startTime >= %@) AND (startTime < %@)", startDate as NSDate, endDate as NSDate)
        
        if let workouts  = CoreDataBase.fetchEntities(withEntity: "Workout", expecting: Workout.self, predicates: [predicate]) {
            self.workouts = workouts
            for workout in self.workouts {
                let viewModel = MonthWorkoutListCellViewModel(workout: workout)
                self.cellViewModels.append(viewModel)
            }
        }
        
    }
    
}

extension MonthWorkoutListViewModel: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MonthWorkoutListCell.cellIdentifier,
            for: indexPath
        ) as? MonthWorkoutListCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: self.cellViewModels[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.workouts.count

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let parentViewController = tableView.getParentViewController(tableView) {
            let workoutViewModel = WorkoutViewModel(workout: cellViewModels[indexPath.row].workout)
            let workoutViewController = WorkoutViewController(viewModel: workoutViewModel)
            workoutViewController.modalPresentationStyle = .fullScreen
            parentViewController.present(workoutViewController, animated: true)
        }

    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let workout =  self.cellViewModels[indexPath.row].workout
        
        // Trailing delete workout action
        let deleteWorkoutAction = UIContextualAction(style: .destructive, title: "") {  (contextualAction, view, boolValue) in
            
            // Controller
            let deleteWorkoutAlertController = UIAlertController(title: "Delete \(String(describing: workout.title!))?", message: "This action cannot be undone.",preferredStyle: .actionSheet)
            
            // Actions
            deleteWorkoutAlertController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                CoreDataBase.context.delete(workout)
                CoreDataBase.save()

            }))
            deleteWorkoutAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            if let parentViewController = tableView.getParentViewController(tableView) {
                parentViewController.present(deleteWorkoutAlertController, animated: true)
            }
        }
        
        deleteWorkoutAction.image = UIImage(systemName: "trash")
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteWorkoutAction])
        return swipeActions
    }
}

//
//  WorkoutViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/14/23.
//

import UIKit
import CoreData

final class WorkoutViewModel: NSObject {
    
    public let workout: Workout
    public var tableView: UITableView?
    private lazy var cellViewModels: [WorkoutGeneralStatsViewCellViewModel] = {
        return WorkoutGeneralStatsViewType.allCases.compactMap { type in
            return WorkoutGeneralStatsViewCellViewModel(type: type, workout: self.workout)
        }
    }()
    lazy var fetchedResultsController: NSFetchedResultsController<Workout> = {
        return CoreDataBase.creatFetchedResultsController(withEntityName: "Workout", expecting: Workout.self, predicates: [NSPredicate(format: "SELF = %@", self.workout.objectID)])
    }()
    
    // MARK: - Init
    init(workout: Workout) {
        self.workout = workout
        super.init()
        
        CoreDataBase.configureFetchedResults(controller: self.fetchedResultsController, expecting: Workout.self, with: self)
    }
}

// MARK: - Table View Delegate
extension WorkoutViewModel: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: WorkoutGeneralStatsViewCell.cellIdentifier,
            for: indexPath
        ) as? WorkoutGeneralStatsViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

// MARK: - Fetched Results Controller Delegate
extension WorkoutViewModel: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        guard let managedObject = anObject as? NSManagedObject else {
            return // Ensure the object is a managed object
        }
        let notesIndexPath = IndexPath(row: 4, section: 0)
        let changedProperties = managedObject.changedValues()
        
        // Update notes if those have changes (the rest will update automatically)
        if changedProperties["notes"] != nil {
            self.tableView?.reloadRows(at: [notesIndexPath], with: .automatic)
        }
    }
}

// MARK: - Text Field Delegate
extension WorkoutViewModel: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.workout.title = textField.text
        CoreDataBase.save()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.selectAll(nil)
    }
}

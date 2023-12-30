//
//  SettListVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 10/17/23.
//

import Foundation
import UIKit
import CoreData

final class SettListVM: NSObject {
    public var tableView: UITableView?
    private var cellVMs: [SettListCellVM] = []
    private var settCollection: SettCollection
    public var isExpanded: Bool
    lazy var fetchedResultsController: NSFetchedResultsController<SettCollection> = {
        return CoreDataBase.createFetchedResultsController(
                    withEntityName: "SettCollection",
                    expecting: SettCollection.self,
                    predicates: [NSPredicate(format: "SELF = %@", self.settCollection.objectID)])
    }()
    
    // MARK: - Init
    init(settCollection: SettCollection, isExpanded: Bool) {
        self.settCollection = settCollection
        self.isExpanded = isExpanded
        super.init()
        self.configure()
    }
    
    // MARK: - Configurations
    public func configure() {
        // Listen for updates to specific workout
        CoreDataBase.configureFetchedResults(controller: self.fetchedResultsController, expecting: SettCollection.self, with: self)
        guard let settCollection = self.fetchedResultsController.fetchedObjects?.first else {
            return
        }
        // New information, overwrite
        self.cellVMs = []
        
        for i in 0..<(settCollection.setts?.count ?? 0) {
            guard let settCast = settCollection.setts?.array[i] as? Sett else {
                continue
            }
            self.cellVMs.append(SettListCellVM(sett: settCast, settIndex: i))
        }
    }
    
    // MARK: - Actions
    public func addSett() {
        let sett = Sett(context: CoreDataBase.context)
        self.settCollection.addToSetts(sett)
        self.settCollection.workoutExercise?.numSetts += 1
        CoreDataBase.save()
    }
}

// MARK: - Table View Delegate
extension SettListVM: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // If last row return action buttons
        if indexPath.row == self.cellVMs.count {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SettListActionView.cellIdentifier,
                for: indexPath) as? SettListActionView else {
                    fatalError("Unsupported cell")
            }
            cell.configure(with: self)
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SettListCell.cellIdentifier,
            for: indexPath
        ) as? SettListCell else {
            fatalError("Unsupported cell")
        }
        
        cell.configure(with: self.cellVMs[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // All the setts + action button group
        return self.cellVMs.count + 1

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let sett =  self.cellVMs[indexPath.row].sett
            
        // Copy sett action
        let copySettAction = UIContextualAction(style: .normal, title: "") {  _, _, _ in
            
            // Copy Sett
            self.settCollection.workoutExercise?.numSetts += 1
            let copiedSett = Sett(context: CoreDataBase.context)
            copiedSett.weight = sett.weight
            copiedSett.reps = sett.reps
            copiedSett.notes = sett.notes
            
            // Insert at correct spot
            self.settCollection.insertIntoSetts(copiedSett, at: indexPath.row)
            CoreDataBase.save()
            
            // Dismiss Menu
            tableView.setEditing(false, animated: true)
        }
        
        copySettAction.image = UIImage(systemName: "square.3.layers.3d.down.backward")
        copySettAction.backgroundColor = .systemGray
        let swipeActions = UISwipeActionsConfiguration(actions: [copySettAction])
        
        return swipeActions
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let sett =  self.cellVMs[indexPath.row].sett
        
        // Trailing delete sett action
        let deleteSettAction = UIContextualAction(style: .destructive, title: "") {  _, _, _ in
            
            // Controller
            let deleteSettAlertController = UIAlertController(
                                                title: "Delete this set?",
                                                message: "This action cannot be undone.",
                                                preferredStyle: .actionSheet)
            
            // Actions
            deleteSettAlertController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                self.settCollection.workoutExercise?.numSetts -= 1
                self.settCollection.removeFromSetts(sett)
                CoreDataBase.context.delete(sett)
                if let workoutExercise = self.settCollection.workoutExercise, workoutExercise.numSetts == 0 {
                    CoreDataBase.context.delete(self.settCollection)
                    CoreDataBase.context.delete(workoutExercise)
                }
                CoreDataBase.save()

            }))
            deleteSettAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            if let parentViewController = tableView.getParentViewController(tableView) {
                parentViewController.present(deleteSettAlertController, animated: true)
            }
        }
        
        deleteSettAction.image = UIImage(systemName: "trash")
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteSettAction])
        return swipeActions
    }
}

// MARK: - Fetched Results Controller Delegate
extension SettListVM: NSFetchedResultsControllerDelegate {
    // Update screen if CRUD conducted on SettCollection
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        DispatchQueue.main.async {
            self.configure()
            self.tableView?.reloadData()
        }
    }
}

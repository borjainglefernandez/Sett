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
    private var settCollection: SettCollection?
    public var isExpanded: Bool
    public var inputTags: [Int]
    lazy var fetchedResultsController: NSFetchedResultsController<SettCollection> = {
        return CoreDataBase.createFetchedResultsController(
                    withEntityName: "SettCollection",
                    expecting: SettCollection.self,
                    predicates: [NSPredicate(format: "SELF = %@", self.settCollection?.objectID ?? 0)])
    }()
    
    // MARK: - Init
    init(settCollection: SettCollection, isExpanded: Bool, inputTags: [Int]) {
        self.settCollection = settCollection
        self.isExpanded = isExpanded
        self.inputTags = inputTags
        super.init()
        self.configure()
    }
    
    // MARK: - Configurations
    public func configure() {
        // New information, overwrite
        self.cellVMs = []
        
        // Listen for updates to specific workout
        CoreDataBase.configureFetchedResults(controller: self.fetchedResultsController, expecting: SettCollection.self, with: self)
        guard let settCollection = self.fetchedResultsController.fetchedObjects?.first else {
            return
        }

        var inputTagsCopy = self.inputTags // Make a copy so it resets properly
        
        for i in 0..<(settCollection.setts?.count ?? 0) {
            guard let settCast = settCollection.setts?.array[i] as? Sett else {
                continue
            }
            let viewModel = SettListCellVM(sett: settCast, settIndex: i)
            viewModel.inputTags = Array(inputTagsCopy.prefix(3))
            
            if inputTagsCopy.count >= 3 {
                inputTagsCopy.removeFirst(3)
            }
            self.cellVMs.append(viewModel)
        }
    }
    
    // MARK: - Actions
    public func addSett() {
        let sett = Sett(context: CoreDataBase.context)
        self.settCollection?.addToSetts(sett)
        self.settCollection?.workoutExercise?.numSetts += 1
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
        let cellVM =  self.cellVMs[indexPath.row]
        
        // Autofill sett action
        let autoFillSettAction = UIContextualAction(style: .normal, title: "") {  _, _, _ in
            
                // Autofill sett from previous
                cellVM.autofillSettFromPrevious()
                
                // Dismiss Menu
                tableView.setEditing(false, animated: true)
            
                // Update UI
                self.configure()
                self.tableView?.reloadData()
            }
        autoFillSettAction.image = UIImage(systemName: "checkmark.rectangle.stack.fill")
        autoFillSettAction.backgroundColor = .systemCyan
  
        // Copy sett action
        let copySettAction = UIContextualAction(style: .normal, title: "") {  _, _, _ in
            
            // Copy Sett
            self.settCollection?.workoutExercise?.numSetts += 1
            let copiedSett = Sett(context: CoreDataBase.context)
            let sett = cellVM.sett
            copiedSett.weight = sett.weight
            copiedSett.reps = sett.reps
            copiedSett.notes = sett.notes
            
            // Insert at correct spot
            self.settCollection?.insertIntoSetts(copiedSett, at: indexPath.row + 1)
            CoreDataBase.save()
            
            // Dismiss Menu
            tableView.setEditing(false, animated: true)
        }
        
        copySettAction.image = UIImage(systemName: "square.3.layers.3d.down.backward")
        copySettAction.backgroundColor = .systemGray
        
        var actions: [UIContextualAction] = [copySettAction]
        
        if cellVM.sett.reps == nil || cellVM.sett.weight == nil {
            actions.insert(autoFillSettAction, at: 0)
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: actions)
        
        return swipeActions
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let sett =  self.cellVMs[indexPath.row].sett
        
        // Trailing delete sett action
        let deleteSettAction = UIContextualAction(style: .destructive, title: "") {  _, _, _ in
            
            // Controller
            let deleteSettAlertController = DeleteAlertViewController(
                                                title: "Delete this set?",
                                                deleteAction: ({
                                                    // Delete sett
                                                    self.settCollection?.workoutExercise?.numSetts -= 1
                                                    self.settCollection?.removeFromSetts(sett)
                                                    CoreDataBase.context.delete(sett)
                                                    
                                                    // If last sett, delete sett collection
                                                    if let settCollection = self.settCollection,
                                                       let workoutExercise = settCollection.workoutExercise, workoutExercise.numSetts == 0 {
                                                        CoreDataBase.context.delete(settCollection)
                                                        CoreDataBase.context.delete(workoutExercise)
                                                    }
                                                    CoreDataBase.save()
                                                    tableView.setEditing(false, animated: true) // Dismiss Menu
                                                }))
            
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
            // If we deleted sett collection, clean up
            if type == .delete {
                if let deletedSettCollection = anObject as? SettCollection {
                   if deletedSettCollection == self.settCollection {
                       self.settCollection = nil
                   }
                }
            }
            self.configure()
            self.tableView?.reloadData()
        }
    }
}

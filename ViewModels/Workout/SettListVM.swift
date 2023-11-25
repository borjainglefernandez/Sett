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
    public var settListView: SettListView?
    private var cellVMs: [SettListCellVM] = []
    private var settCollection: SettCollection
    lazy var fetchedResultsController: NSFetchedResultsController<SettCollection> = {
        return CoreDataBase.createFetchedResultsController(
                    withEntityName: "SettCollection",
                    expecting: SettCollection.self,
                    predicates: [NSPredicate(format: "SELF = %@", self.settCollection.objectID)])
    }()
    
    // MARK: - Init
    init(settCollection: SettCollection) {
        self.settCollection = settCollection
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
        
        for sett in settCollection.setts ?? [] {
            guard let settCast = sett as? Sett else {
                continue
            }
            self.cellVMs.append(SettListCellVM(sett: settCast))
        }
    }
}

// MARK: - Table View Delegate
extension SettListVM: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        return self.cellVMs.count

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43
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
                CoreDataBase.context.delete(sett)
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
            self.settListView?.tableView.reloadData()
        }
    }
}

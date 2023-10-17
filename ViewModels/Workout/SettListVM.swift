//
//  SettListVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 10/17/23.
//

import Foundation
import UIKit

final class SettListVM: NSObject {
    public var settListView: SettListView?
    private var cellVMs: [SettListCellVM] = []
    
    // MARK: - Init
    init(settCollection: SettCollection) {
        for sett in settCollection.setts ?? [] {
            guard let settCast = sett as? Sett else {
                continue
            }
            cellVMs.append(SettListCellVM(sett: settCast))
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

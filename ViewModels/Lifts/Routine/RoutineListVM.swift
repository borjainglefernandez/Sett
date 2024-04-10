//
//  RoutineListVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 9/10/23.
//

import Foundation
import UIKit

class RoutineListVM: NSObject {
    public var routinesListView: RoutineListView?
    private var cellVMs: [RoutineListCellVM] = []
    
    // MARK: - Init
    init(routines: [Routine]) {
        for routine in routines {
            self.cellVMs.append(RoutineListCellVM(routine: routine))
        }
    }
    
    // MARK: - Actions
    
}

// MARK: - Table View Delegate
extension RoutineListVM: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RoutineListCell.cellIdentifier,
            for: indexPath
        ) as? RoutineListCell else {
            fatalError("Unsupported cell")
        }
        
        // Only show divider if not the last exercise in the category
        let showDivider = indexPath.row != self.cellVMs.count - 1
        
        cell.configure(with: self.cellVMs[indexPath.row], showDivider: showDivider)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let parentViewController = tableView.getParentViewController(tableView) {
            let routine = self.cellVMs[indexPath.row].routine
            let individualRoutineModalViewController = IndividualRoutineViewController(viewModel: IndividualRoutineVM(routine: routine))
            individualRoutineModalViewController.modalPresentationStyle = .fullScreen
            parentViewController.present(individualRoutineModalViewController, animated: true)
        }

    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let routine =  self.cellVMs[indexPath.row].routine
        
        // Trailing delete routine action
        let deleteRoutineAction = UIContextualAction(style: .destructive, title: "") {  _, _, _ in
            
            // Controller
            let deleteRoutineAlertController = DeleteAlertViewController(
                title: "Delete \(String(describing: routine.name ?? ""))?",
                deleteAction: ({
                    CoreDataBase.context.delete(routine)
                    CoreDataBase.save()
                    tableView.setEditing(false, animated: true) // Dismiss Menu
                }))
            
            if let parentViewController = tableView.getParentViewController(tableView) {
                parentViewController.present(deleteRoutineAlertController, animated: true)
            }
        }
        
        deleteRoutineAction.image = UIImage(systemName: "trash")
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteRoutineAction])
        return swipeActions
    }
}

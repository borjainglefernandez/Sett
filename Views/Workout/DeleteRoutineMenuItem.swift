//
//  DeleteRoutineMenuItem.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/11/24.
//

import Foundation
import UIKit

class DeleteRoutineMenuItem: NSObject {
    
    private let routine: Routine
    private let menuView: UIView
    
    init(routine: Routine, menuView: UIView) {
        self.routine = routine
        self.menuView = menuView
    }
    
    private func deleteRoutine() {
        if let parentViewController = self.menuView.getParentViewController(self.menuView) {
            parentViewController.dismiss(animated: true)
        }
        CoreDataBase.context.delete(self.routine)
        CoreDataBase.save()
    }
    
    public func getMenuItem() -> UIAction {
        let actionHandler: UIActionHandler = { _ in
            if let parentViewController = self.menuView.getParentViewController(self.menuView) {
                let deleteRoutineViewController = DeleteAlertViewController(
                    title: "Delete \(self.routine.name ?? "")",
                    deleteAction: (self.deleteRoutine))
                parentViewController.present(deleteRoutineViewController, animated: true)
            }
        }
        
        return UIAction(
            title: "Delete Routine",
            image: UIImage(systemName: "trash"),
            attributes: [.destructive],
            state: .off,
            handler: actionHandler
        )
    }
}

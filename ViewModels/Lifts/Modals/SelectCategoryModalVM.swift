//
//  SelectCategoryModal.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/29/23.
//

import Foundation
import UIKit

final class SelectCategoryModalVM: NSObject {
    
    public let routine: Routine
    
    // MARK: - Init
    init(routine: Routine) {
        self.routine = routine
    }
    
    public func selectCellCallback(with title: String, and subTitle: String, for type: ModalTableViewType, view: UIView?) {
        guard let category: Category = CoreDataBase.fetchEntity(
                                        withEntity: "Category",
                                        expecting: Category.self,
                                        predicates: [NSPredicate(format: "name = %@", title)]) else {
            return
        }
        if let view = view, let parentViewController = view.getParentViewController(view), parentViewController.presentedViewController == nil {
            let selectExerciseModalViewController = SelectExerciseModalViewController(routine: self.routine, category: category)
            parentViewController.present(selectExerciseModalViewController, animated: true)
        }
    }
}

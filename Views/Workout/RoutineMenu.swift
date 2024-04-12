//
//  RoutineMenu.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/11/24.
//

import Foundation
import UIKit

class RoutineMenu: NSObject {
    private let routine: Routine
    private let overallView: UIView
    
    init(routine: Routine, overallView: UIView) {
        self.routine = routine
        self.overallView = overallView
    }
    
    public func getMenu() -> UIMenu {
        let copyRoutineMenuItem = CopyRoutineMenuItem(routine: self.routine, menuView: self.overallView).getMenuItem()
        let deleteRoutineMenuItem = DeleteRoutineMenuItem(routine: self.routine, menuView: self.overallView).getMenuItem()
        let menu = UIMenu(preferredElementSize: .large, children: [copyRoutineMenuItem, deleteRoutineMenuItem])
        return menu
    }
}

//
//  RoutineListCellVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 9/10/23.
//

import Foundation

final class RoutineListCellVM: NSObject {
    public let routine: Routine

    // MARK: - Init
    init(routine: Routine) {
        self.routine = routine
    }
}

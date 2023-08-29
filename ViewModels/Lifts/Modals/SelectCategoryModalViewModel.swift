//
//  SelectCategoryModal.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/29/23.
//

import Foundation

final class SelectCategoryModalViewModel: NSObject {
    
    public let routine: Routine
    
    // MARK: - Init
    init(routine: Routine) {
        self.routine = routine
    }
    
    public func selectCellCallback(with title: String, for type: ModalTableViewType) {
        print(title)
    }
}

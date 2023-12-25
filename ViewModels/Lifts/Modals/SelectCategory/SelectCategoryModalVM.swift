//
//  SelectCategoryModal.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/29/23.
//

import Foundation
import UIKit

class SelectCategoryModalVM: NSObject {
    
    // MARK: - Init
    override init() {
    }
    
    // MARK: - Callback
    public func selectCellCallback(with title: String, and subTitle: String, for type: ModalTableViewType, view: UIView?) {
        fatalError("This method must be implemented in subclass.")
    }
}

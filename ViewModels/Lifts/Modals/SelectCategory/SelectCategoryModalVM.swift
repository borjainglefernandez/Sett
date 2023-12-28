//
//  SelectCategoryModal.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/29/23.
//

import Foundation
import UIKit

class SelectCategoryModalVM: NSObject {
    
    // Index to replace workout exercise upon selection
    public let replacementIndex: Int?
    
    // MARK: - Init
    init(replacementIndex: Int?) {
        self.replacementIndex = replacementIndex
    }
    
    // MARK: - Callback
    public func selectCellCallback(with title: String, and subTitle: String, for type: ModalTableViewType, view: UIView?) {
        fatalError("This method must be implemented in subclass.")
    }
}

//
//  AddCategoryViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/26/23.
//

import Foundation
import UIKit

class AddCategoryViewModel: NSObject {
    private var newCategoryName: String = ""
    private let alertController: UIAlertController
    
    init(alertController: UIAlertController) {
        self.alertController = alertController
    }
    
    public func createNewCategory() {
        if !newCategoryName.isEmpty {
            let newCategory = Category(context: CoreDataBase.context)
            newCategory.name = self.newCategoryName
            CoreDataBase.save()
        }
    }

}

extension AddCategoryViewModel: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.newCategoryName = textField.text ?? ""
        self.alertController.actions[0].isEnabled = !self.newCategoryName.isEmpty
    }
}

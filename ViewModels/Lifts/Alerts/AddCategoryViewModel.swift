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
    private let category: Category?
    public let alertController: UIAlertController
    
    lazy var confirmAction: UIAlertAction = {
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) {_ in
            if self.category != nil {
                self.updateCategoryName()
            } else {
                self.createNewCategory()
            }
        }
        confirmAction.isEnabled = false
        return confirmAction
    }()
    
    private var cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    
    // MARK: - Init
    init(category: Category? = nil) {
        self.alertController = UIAlertController(title: "", message: nil, preferredStyle: .alert)
        self.category = category
        super.init()
        self.configureTitle()
        self.alertController.view.tintColor = .systemCyan
        self.alertController.addTextField { textField in
            textField.placeholder = "Category name"
            textField.text = category?.name
            textField.delegate = self
        }
        self.alertController.addAction(self.confirmAction)
        self.alertController.addAction(self.cancelAction)
    }
    
    // MARK: - Configurations
    private func configureTitle() {
        if self.category != nil {
            self.alertController.title = "Edit category name"
        } else {
            self.alertController.title = "New category name"
        }
    }

    // MARK: - Actions
    private func createNewCategory() {
        if !newCategoryName.isEmpty {
            let newCategory = Category(context: CoreDataBase.context)
            newCategory.name = self.newCategoryName
            CoreDataBase.save()
        }
    }
    
    private func updateCategoryName() {
        if !newCategoryName.isEmpty {
            self.category?.name = newCategoryName
            CoreDataBase.save()
        }
    }

}

extension AddCategoryViewModel: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.newCategoryName = textField.text ?? ""
        self.confirmAction.isEnabled = !self.newCategoryName.isEmpty
    }
}

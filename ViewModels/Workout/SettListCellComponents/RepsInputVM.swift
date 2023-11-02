//
//  RepsInputVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 10/31/23.
//

import Foundation
import UIKit

final class RepsInputVM: NSObject {
    public let sett: Sett

    // MARK: - Init
    init(sett: Sett) {
        self.sett = sett
    }
}

// MARK: - Text Field Delegate
extension RepsInputVM: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let reps = NumberFormatter().number(from: textField.text ?? "") {
            self.sett.reps = reps
            CoreDataBase.save()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Calculate the new text length if the user's input is accepted
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // Check if the new text length exceeds the limit (4 characters)
        return newText.count <= 4
    }
}

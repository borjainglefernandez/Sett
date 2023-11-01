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
}

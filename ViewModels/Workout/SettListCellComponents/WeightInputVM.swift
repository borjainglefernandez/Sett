//
//  WeightInputVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 10/31/23.
//

import Foundation
import UIKit

final class WeightInputVM: NSObject {
    public let sett: Sett

    // MARK: - Init
    init(sett: Sett) {
        self.sett = sett
    }
}

// MARK: - Text Field Delegate
extension WeightInputVM: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let weight = NumberFormatter().number(from: textField.text ?? "") {
            self.sett.weight = weight
            CoreDataBase.save()
        }
    }
}

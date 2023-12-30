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
    private let previousSett: Sett?
    private let setNetWeightLabel: (String) -> Void

    // MARK: - Init
    init(sett: Sett, 
         previousSett: Sett?,
         setNetWeightLabel: @escaping((String) -> Void)) {
        self.sett = sett
        self.previousSett = previousSett
        self.setNetWeightLabel = setNetWeightLabel
    }
    
    // MARK: - Actions
    private func setNetWeight() {
        if let currentWeight = self.sett.weight as? Int,
           let previousWeight = self.previousSett?.weight as? Int {
                
                // Sett net progress
                let netWeight: Int64 = Int64(currentWeight - previousWeight)
                let settNetProgress = self.sett.netProgress ?? NetProgress(context: CoreDataBase.context)
                settNetProgress.weight = netWeight
                settNetProgress.settNP = sett
                
                // Set net weight label
                self.setNetWeightLabel(NumberUtils.getNumWithSign(for: Int(netWeight)))
        }
    }
}

// MARK: - Text Field Delegate
extension WeightInputVM: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let weight = NumberFormatter().number(from: textField.text ?? "") {
            self.sett.weight = weight
            self.setNetWeight()
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

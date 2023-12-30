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
    private let previousSett: Sett?
    private let setNetRepsLabel: (String) -> Void

    // MARK: - Init
    init(sett: Sett, 
         previousSett: Sett?,
         setNetRepsLabel: @escaping((String) -> Void)) {
        self.sett = sett
        self.previousSett = previousSett
        self.setNetRepsLabel = setNetRepsLabel
    }
    
    // MARK: - Actions
    private func setNetReps() {
        if let currentReps = self.sett.reps as? Int,
           let previousReps = self.previousSett?.reps as? Int {
                
                // Sett net progress
                let netReps: Int64 = Int64(currentReps - previousReps)
                let settNetProgress = self.sett.netProgress ?? NetProgress(context: CoreDataBase.context)
                settNetProgress.reps = netReps
                settNetProgress.settNP = sett
                
                // Set net reps label
                self.setNetRepsLabel(NumberUtils.getNumWithSign(for: Int(netReps)))
        }
    }
}

// MARK: - Text Field Delegate
extension RepsInputVM: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let reps = NumberFormatter().number(from: textField.text ?? "") {
           self.sett.reps = reps
           self.setNetReps()
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

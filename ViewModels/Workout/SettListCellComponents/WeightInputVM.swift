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
        super.init()
        self.setNetWeight()
    }
    
    // MARK: - Actions
    private func setNetWeight() {
        // Get rid of net progress from before for workout
        let workoutNetProgress = self.sett.partOf?.workoutExercise?.workout?.netProgress ?? NetProgress(context: CoreDataBase.context)
                if let previousNetProgress = self.sett.netProgress {
            workoutNetProgress.weight -= previousNetProgress.weight
        }
        
        // Get current set net progress
        let settNetProgress = self.sett.netProgress ?? NetProgress(context: CoreDataBase.context)
        
        // If there is a previous sett
        if let currentWeight = self.sett.weight as? Int,
           let previousWeight = self.previousSett?.weight as? Int {
                
                // Sett net progress
                let netWeight: Int64 = Int64(currentWeight - previousWeight)
                settNetProgress.weight = netWeight
                settNetProgress.settNP = sett
                
                // Set net weight label
                self.setNetWeightLabel(NumberUtils.getNumWithSign(for: Int(netWeight)))
        } else { // If no previous sett
            
            // Reset net progress to 0
            settNetProgress.weight = 0
            settNetProgress.settNP = sett
            
            // Set net reps label
            self.setNetWeightLabel("0")
        }
        
        // Add new net progress to workout
        workoutNetProgress.weight += settNetProgress.weight
        if let workout = self.sett.partOf?.workoutExercise?.workout {
            workout.netProgress = workoutNetProgress
        }
                
        CoreDataBase.save()
    }
}

// MARK: - Text Field Delegate
extension WeightInputVM: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == nil || textField.text == "" {
            self.sett.weight = nil
        }
        
        if let weight = NumberFormatter().number(from: textField.text ?? "") {
            self.sett.weight = weight
        }
        
        self.setNetWeight()
        CoreDataBase.save()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Calculate the new text length if the user's input is accepted
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // Check if the new text length exceeds the limit (4 characters)
        return newText.count <= 4
    }
}

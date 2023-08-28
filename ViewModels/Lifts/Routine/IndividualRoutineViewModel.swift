//
//  IndividualRoutineViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/28/23.
//

import Foundation
import UIKit

final class IndividualRoutineViewModel: NSObject {
    public let routine: Routine
    
    // MARK: - Init
    init(routine: Routine = Routine(context: CoreDataBase.context)) {
        self.routine = routine
        super.init()
    }
    
}

// MARK: - Text Field Delegate
extension IndividualRoutineViewModel: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.routine.name = textField.text
        CoreDataBase.save()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.selectAll(nil)
    }
}

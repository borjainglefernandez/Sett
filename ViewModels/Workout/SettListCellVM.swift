//
//  SettListCellVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 10/17/23.
//

import Foundation
import UIKit

final class SettListCellVM: NSObject {
    
    public let sett: Sett
    public let weightInputVM: WeightInputVM
    public let repsInputVM: RepsInputVM
    public let settNotesInputVM: SettNotesInputVM
    
    // MARK: - Init
    init(sett: Sett) {
        self.sett = sett
        self.weightInputVM = WeightInputVM(sett: self.sett)
        self.repsInputVM = RepsInputVM(sett: self.sett)
        self.settNotesInputVM = SettNotesInputVM(sett: self.sett)
    }
}

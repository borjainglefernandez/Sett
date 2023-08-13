//
//  InidividualExerciseModal.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/13/23.
//

import UIKit

class IndividualExerciseModal: UIView {
    
    private let viewModel: IndividualExerciseModalViewModel
    
    // MARK: - Init
    init(frame: CGRect = .zero, viewModel: IndividualExerciseModalViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
}

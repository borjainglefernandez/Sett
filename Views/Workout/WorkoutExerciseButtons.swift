//
//  WorkoutExerciseButtons.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 11/18/23.
//

import UIKit

class WorkoutExerciseButtons: UIView {
    // Add Sett
    private let addSettButton: UIButton = IconButton(imageName: "plus.square")
    
    // MARK: - Init
    override init(frame: CGRect  = .zero) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = .red
        self.addSubviews(self.addSettButton)
        
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }

}

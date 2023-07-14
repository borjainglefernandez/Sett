//
//  WorkoutView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/14/23.
//

import UIKit

final class WorkoutView: UIView {

    private let viewModel: WorkoutViewModel
    
    // MARK: - Init
     init(frame: CGRect, viewModel: WorkoutViewModel) {
         self.viewModel = viewModel
         super.init(frame: frame)
         translatesAutoresizingMaskIntoConstraints = false

         backgroundColor = .systemCyan
         self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initializer")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
        
        ])
    }

}

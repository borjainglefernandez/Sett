//
//  WorkoutBottomBarView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 3/5/24.
//

import UIKit

class WorkoutBottomBarView: UIView {
    
    private let viewModel: WorkoutBottomBarVM
    
    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        return dateLabel
    }()
    
    
    // MARK: - Init
    init(frame: CGRect, viewModel: WorkoutBottomBarVM) {
        self.viewModel = viewModel
        
        super.init()
        
        self.layer.cornerRadius = 15
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

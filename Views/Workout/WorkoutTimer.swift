//
//  WorkoutTimer.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 3/6/24.
//

import UIKit

class WorkoutTimer: UILabel {
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.font = .systemFont(ofSize: 17, weight: .bold)
        self.text = "11:58"
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
}

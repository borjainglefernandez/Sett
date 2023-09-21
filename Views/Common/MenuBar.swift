//
//  MenuBar.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/21/23.
//

import UIKit

class MenuBar: UIView {
    
    // MARK: - Init
    init(frame: CGRect = .zero, maskedCorners: CACornerMask? = nil) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemGray4
        self.layer.cornerRadius = 15
        if let maskedCorners = maskedCorners {
            layer.maskedCorners = maskedCorners
        }
        
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}

//
//  Divider.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 10/20/23.
//

import UIKit

class Divider: UIView {
    
    // MARK: - Init
    init(frame: CGRect = .zero, backgroundColor: UIColor = .label) {
        super.init(frame: frame)
        self.backgroundColor = backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

}

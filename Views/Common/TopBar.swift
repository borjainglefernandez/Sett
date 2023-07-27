//
//  TopBar.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/21/23.
//

import UIKit

class TopBar: UIView {
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray4
        layer.cornerRadius = 15
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}

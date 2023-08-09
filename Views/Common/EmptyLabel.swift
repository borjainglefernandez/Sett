//
//  EmptyLabel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/8/23.
//

import UIKit

class EmptyLabel: UILabel {
    
    // MARK: - Init
    init(frame: CGRect, labelText: String) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .label
        font = .systemFont(ofSize: 17.0, weight: .bold)
        text = labelText
        textAlignment = .center
        isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
}

//
//  TitleLabel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/22/23.
//

import UIKit

class TitleLabel: UILabel {
    
    // MARK: - Init
    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        textColor = .label
        font = .systemFont(ofSize: 17, weight: .bold)
        text = title
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
}

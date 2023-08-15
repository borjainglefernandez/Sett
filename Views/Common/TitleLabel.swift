//
//  TitleLabel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/22/23.
//

import UIKit

class Label: UILabel {
    
    // MARK: - Init
    init(frame: CGRect = .zero, title: String, fontSize: Double = 17.0, weight: UIFont.Weight = .bold) {
        super.init(frame: frame)
        textColor = .label
        font = .systemFont(ofSize: fontSize, weight: weight)
        text = title
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 1
        lineBreakMode = .byTruncatingTail
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
}

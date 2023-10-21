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
        self.textColor = .label
        self.font = .systemFont(ofSize: fontSize, weight: weight)
        self.text = title
        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = 1
        self.lineBreakMode = .byTruncatingTail
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Setter
    public func setTitle(title: String) {
        self.text = title
    }
}

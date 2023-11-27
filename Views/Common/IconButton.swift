//
//  IconButton.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/22/23.
//

import UIKit

class IconButton: UIButton {
    
    // MARK: - Init
    init(frame: CGRect = .zero, imageName: String, color: UIColor = .systemCyan, fontSize: Double = 17.0, fontWeight: UIFont.Weight = .bold) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // Icon on button
        let config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: fontSize, weight: fontWeight))
        self.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        let iconImage = UIImage(systemName: imageName)
        iconImage?.withTintColor(color)
        self.setImage(iconImage, for: .normal)
        
        self.tintColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
}

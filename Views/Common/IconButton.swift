//
//  IconButton.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/22/23.
//

import UIKit

class IconButton: UIButton {
    
    // MARK: - Init
    init(frame: CGRect, imageName: String, color: UIColor = .systemCyan, fontSize: Double = 17.0) {
        super.init(frame: frame)

        let config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: fontSize, weight: .bold))
        setPreferredSymbolConfiguration(config, forImageIn: .normal)
        
        let iconImage = UIImage(systemName: imageName)
        setImage(iconImage, for: .normal)
        
        tintColor = color
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
}

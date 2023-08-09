//
//  ExpandCollapseButton.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/8/23.
//

import UIKit

class ExpandCollapseButton: UIButton {

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false

        var config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 17, weight: .bold))
        tintColor = .label
        setPreferredSymbolConfiguration(config, forImageIn: .normal)        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
}

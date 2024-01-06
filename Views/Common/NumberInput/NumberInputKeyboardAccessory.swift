//
//  NumberInputKeyboardAccessory.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 1/3/24.
//

import UIKit

class NumberInputKeyboardAccessory: UIToolbar {

    // MARK: - Init
    override init(frame: CGRect = .zero) {
        super.init(frame: .init(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 44)))
        self.backgroundColor = .systemGray4
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: nil, action: nil)
        let forwardButton = UIBarButtonItem(image: UIImage())
        backButton.tintColor = .systemCyan
        self.setItems([backButton], animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
}

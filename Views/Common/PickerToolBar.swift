//
//  PickerToolBar.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 12/23/23.
//

import UIKit

// Used for flexible spacing in toolbar
let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

class PickerToolBar: UIToolbar {
    
    // Button to perform dismiss toolbar (will be on the end)
    lazy var doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneSelected))
    
    // Action to perform on done
    private var doneSelector: () -> Void
    
    // Component that goes in the middle of the toolbar
    private var middleComponent: UIBarButtonItem

    // MARK: - Init
    init(frame: CGRect = .zero,
         doneSelector: @escaping () -> Void,
         middleComponent: UIBarButtonItem = spaceButton) {
        
        // Instance variables
        self.doneSelector = doneSelector
        self.middleComponent = middleComponent
        super.init(frame: frame)

        // Configurations
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setItems([spaceButton, self.middleComponent, spaceButton, self.doneButton], animated: false)
        self.sizeToFit()
        self.customizeBarButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Configurations
    private func customizeBarButton() {
        
        // Change button color to cyan
        let barButtonItemAppearance = UIBarButtonItem.appearance()
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemCyan]
        barButtonItemAppearance.setTitleTextAttributes(titleTextAttributes, for: .normal)
    }
    
    // MARK: - Actions
    @objc func doneSelected() {
        self.doneSelector()
    }

}

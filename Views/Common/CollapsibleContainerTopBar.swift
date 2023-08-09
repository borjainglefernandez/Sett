//
//  CollapsableContainerTopBar.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/8/23.
//

import UIKit

class CollapsibleContainerTopBar: UIView {

    // Top bar of the category list container
    private let topBar: UIView = TopBar(frame: .zero)
    
    // Title label for the container
    private let titleLabel: UILabel = TitleLabel(frame: .zero, title: "", fontSize: 14.0)
    
    // Button to expand or collapse cell
    private let expandCollapseButton: UIButton = ExpandCollapseButton(frame: .zero)
    
    // MARK: - Init
    init(frame: CGRect = .zero, title: String = "") {
        super.init(frame: frame)
        self.titleLabel.text = title
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.topBar.heightAnchor.constraint(equalTo: self.heightAnchor),
            self.topBar.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.topBar.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            self.titleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 2),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            
            self.expandCollapseButton.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            self.expandCollapseButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
        ])
    }
    
    // MARK: - Actions
    public func setTitleLabelText(title: String) {
        self.titleLabel.text = title
    }

}

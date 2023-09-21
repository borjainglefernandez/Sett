//
//  CollapsableContainerTopBar.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/8/23.
//

import UIKit

class CollapsibleContainerTopBar: UIView {
    
    // View Model to control actions
    private var viewModel: CollapsibleContainerTopBarVM?

    // Top bar of the category list container
    private let topBar: UIView = MenuBar(frame: .zero)
    
    // Title label for the container
    private let titleLabel: UILabel = Label(frame: .zero, title: "", fontSize: 14.0)
    
    // Button to expand or collapse cell
    public let expandCollapseButton: IconButton = IconButton(imageName: "chevron.right", color: .label)
    
    // MARK: - Init
    init(frame: CGRect = .zero, title: String = "") {
        super.init(frame: frame)
        self.titleLabel.text = title
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.expandCollapseButton.addTarget(self, action: #selector(self.collapseExpand), for: .touchUpInside)
        
        self.addSubviews(self.topBar, self.titleLabel, self.expandCollapseButton)
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
            self.expandCollapseButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15)
        ])
    }
    
    // MARK: - Configurations
    public func configure(with viewModel: CollapsibleContainerTopBarVM) {
        self.viewModel = viewModel
        self.changeButtonIcon()
    }
    
    // MARK: - Actions
    @objc func collapseExpand() {
        self.viewModel?.collapseExpand()
    }
    
    public func setTitleLabelText(title: String) {
        self.titleLabel.text = title
    }
    
    public func changeButtonIcon() {
        guard let viewModel = self.viewModel else {
            return
        }
        
        self.topBar.layer.cornerRadius = 15
        
        // Change corner radii and icon depending on whether or not showing or hiding
        var iconImage: UIImage?
        if viewModel.isExpanded {
            self.topBar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            iconImage = UIImage(systemName: "chevron.up")
        } else {
            self.topBar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            iconImage = UIImage(systemName: "chevron.down")
        }
        self.expandCollapseButton.setImage(iconImage, for: .normal)
    }

}

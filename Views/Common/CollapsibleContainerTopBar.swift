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
    public let titleLabel: UILabel = Label(frame: .zero, title: "", fontSize: 14.0)
    
    // Whether or not to show right label
    private var showRightLabel: Bool = false
    
    // Label for portion next to expand collapse button
    public let rightLabel: UILabel = Label(frame: .zero, title: "", fontSize: 14.0)
    
    // Menu
    public let menuButton: IconButton = IconButton(imageName: "ellipsis", color: .label)
    public var menu: UIMenu?
    
    // Button to expand or collapse cell
    public let expandCollapseButton: IconButton = IconButton(imageName: "chevron.right", color: .label)
    
    // MARK: - Init
    init(frame: CGRect = .zero, title: String = "", rightLabelText: String = "", showRightLabel: Bool = false, menu: UIMenu? = nil) {
        super.init(frame: frame)
        self.titleLabel.text = title
        self.rightLabel.text = rightLabelText
        self.showRightLabel = showRightLabel
        self.menu = menu
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.expandCollapseButton.addTarget(self, action: #selector(self.collapseExpand), for: .touchUpInside)
        
        self.addSubviews(self.topBar, self.titleLabel, self.expandCollapseButton, self.menuButton)
        
        if showRightLabel {
            self.addSubview(self.rightLabel)
        }
        self.menuButton.isHidden = self.menu == nil
        
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        if self.menu != nil {
            // Remove expand collapse button constraints
            self.removeConstraints(self.constraints.filter { $0.firstItem === self.expandCollapseButton || $0.secondItem === self.expandCollapseButton })
            
            NSLayoutConstraint.activate([
                self.topBar.heightAnchor.constraint(equalTo: self.heightAnchor),
                self.topBar.leftAnchor.constraint(equalTo: self.leftAnchor),
                self.topBar.rightAnchor.constraint(equalTo: self.rightAnchor),
                
                self.titleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 2),
                self.titleLabel.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
                self.menuButton.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
                self.menuButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
                self.expandCollapseButton.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
                self.expandCollapseButton.rightAnchor.constraint(equalTo: self.menuButton.leftAnchor, constant: -10)
            ])
        } else {
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
        
        if showRightLabel {
            NSLayoutConstraint.activate([
                self.rightLabel.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
                self.rightLabel.rightAnchor.constraint(equalTo: self.expandCollapseButton.leftAnchor, constant: -10)
            ])
        }
    
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
    
    public func setRightLabelText(title: String) {
        self.rightLabel.text = title
    }
    
    public func setMenu(menu: UIMenu) {
        self.menu = menu
        self.menuButton.showsMenuAsPrimaryAction = true
        self.menuButton.menu = menu
        self.menuButton.isHidden = false
        self.addConstraints()
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
            self.rightLabel.isHidden = true
        } else {
            self.topBar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            iconImage = UIImage(systemName: "chevron.down")
            self.rightLabel.isHidden = false
        }
        self.expandCollapseButton.setImage(iconImage, for: .normal)
    }

}

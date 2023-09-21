//
//  ModalTableViewCell.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/14/23.
//

import UIKit

class ModalTableViewCell: UITableViewCell {

    static let cellIdentifier = "ModalTableViewCell"
    
    // Each individual cell container
    private let containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .clear
        return containerView
    }()
    
    // Display title of the cell
    private let titleLabel: UILabel = Label(title: "", fontSize: 15.0, weight: .regular)
    
    // Display subtitle of the cell
    private let subTitleLabel: UILabel = Label(title: "", fontSize: 10.0, weight: .regular)
    
    // Radio Button Icon
    public let radioIconButton: UIImageView = UIImageView(image: UIImage(systemName: "button.programmable"))
    
    // Arrow Icon
    private let arrowIconButton: UIButton = IconButton(imageName: "chevron.right", color: .label, fontSize: 17.0)
    
    // Dividier
    private let divider: UIView = {
        let divider = UIView()
        divider.backgroundColor = .label
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear // Allows for customisability of cell
        self.configureClearSelectedBackground()
        
        self.contentView.addSubviews(self.containerView, self.titleLabel, self.subTitleLabel,
                                     self.radioIconButton, self.arrowIconButton, self.divider)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    override func prepareForReuse() {
        self.titleLabel.text = nil
        self.subTitleLabel.text = nil
        self.divider.isHidden = false
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        self.radioIconButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Center title vertically if there is no subtitle
        if self.subTitleLabel.text!.isEmpty {
            NSLayoutConstraint.activate([
                self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5)
            ])
        }
        
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: self.topAnchor),
            self.containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.containerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.985),
            self.containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.985),
            
            self.titleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 2),
            
            self.subTitleLabel.leftAnchor.constraint(equalTo: self.titleLabel.leftAnchor),
            self.subTitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5),
            
            self.arrowIconButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.arrowIconButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            
            self.radioIconButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.radioIconButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            
            self.divider.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.95),
            self.divider.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.divider.heightAnchor.constraint(equalToConstant: 1),
            self.divider.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    // MARK: - Configurations
    public func configure(with viewModel: ModalTableViewCellVM, showDivider: Bool = true) {
        self.titleLabel.text = viewModel.title
        self.subTitleLabel.text = viewModel.subTitle
        
        if !showDivider {
            self.divider.isHidden = true
        }
        
        if viewModel.modalTableViewSelectionType == .toggle {
            self.arrowIconButton.isHidden = true
        } else {
            self.radioIconButton.isHidden = true
        }
        self.selectDeselectCell(select: viewModel.selected)
        self.addConstraints()
    }
}

extension ModalTableViewCell: SelectedModalTableViewCellDelegate {
    func selectDeselectCell(select: Bool) {
        if select {
            self.radioIconButton.tintColor = .systemCyan
        } else {
            self.radioIconButton.tintColor = .label
        }
    }
}

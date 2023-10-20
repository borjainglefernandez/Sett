//
//  SettListCell.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 10/17/23.
//

import UIKit

class SettListCell: UITableViewCell {
    
    static let cellIdentifier = "SettListCell"

    // Each individual cell container
    private let containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .red
        return containerView
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear // Allows for customisability of cell
        self.configureClearSelectedBackground()
        
        self.contentView.addSubviews(self.containerView)
        
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    override func prepareForReuse() {
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: self.topAnchor),
            self.containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.containerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.985),
            self.containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.985)
        ])
    }
    
    // MARK: - Configurations
    public func configure(with viewModel: SettListCellVM) {
    }

}

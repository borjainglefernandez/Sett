//
//  SettListActionView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 12/27/23.
//

import UIKit

class SettListActionView: UITableViewCell {
    
    static let cellIdentifier = "SettListAction"
    
    private var viewModel: SettListVM?
    
    // Add Sett Button
    private let addSettButton: UIButton = IconButton(imageName: "plus.square", color: .label, fontSize: 15.0, fontWeight: .light)
    
    // View Exercise Stats Button
    private let viewStatsButton: UIButton = IconButton(imageName: "chart.bar", color: .label, fontSize: 15.0, fontWeight: .light)
    
    // Reorder Setts Button
    private let reorderSettsButton: UIButton = IconButton(imageName: "line.3.horizontal", color: .label, fontSize: 15.0, fontWeight: .light)

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.configureAppearance()
        self.configureSubviews()
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Configurations
    private func configureAppearance() {
        self.backgroundColor = UIColor.clear // Allows for customisability of cell
        self.configureClearSelectedBackground()
    }
    
    private func configureSubviews() {
        self.addSettButton.addTarget(self, action: #selector(self.addSett), for: .touchUpInside)
        self.contentView.addSubviews(self.addSettButton, self.viewStatsButton, self.reorderSettsButton)
    }
    
    public func configure(with viewModel: SettListVM) {
        self.viewModel = viewModel
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.addSettButton.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 3.375),
            self.addSettButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -5),

            self.viewStatsButton.leftAnchor.constraint(equalToSystemSpacingAfter: self.addSettButton.rightAnchor, multiplier: 3.25),
            self.viewStatsButton.centerYAnchor.constraint(equalTo: self.addSettButton.centerYAnchor),

            self.reorderSettsButton.leftAnchor.constraint(equalToSystemSpacingAfter: self.viewStatsButton.rightAnchor, multiplier: 3.25),
            self.reorderSettsButton.centerYAnchor.constraint(equalTo: self.addSettButton.centerYAnchor)
        
        ])
    }
    
    // MARK: - Actions
    @objc func addSett() {
        self.viewModel?.addSett()
    }
    
}

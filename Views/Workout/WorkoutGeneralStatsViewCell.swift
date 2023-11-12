//
//  WorkoutGeneralStatsViewCell.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/17/23.
//

import UIKit

final class WorkoutGeneralStatsViewCell: UITableViewCell {
    
    static let cellIdentifier = "WorkoutGeneralStatsViewCell"
    
    // Cell container
    private let cellContainer: UIView = {
        let cellContainer = UIView()
        cellContainer.translatesAutoresizingMaskIntoConstraints = false
        return cellContainer
    }()
    
    // Label for the row content
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail // Added truncation for notes
        return label
    }()
    
    // Divider between cells
    private let divider: UIView = Divider()
    
    // Actual content to display on the right side
    private var displayContent: UIView = UIView()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear // Allows for customizability of cell
    
        self.configureClearSelectedBackground()
        self.cellContainer.addSubviews(self.label, self.displayContent, self.divider)
        self.addSubviews(self.cellContainer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            self.cellContainer.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85),
            self.cellContainer.heightAnchor.constraint(equalTo: self.heightAnchor),
            self.cellContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.label.leftAnchor.constraint(equalTo: self.cellContainer.leftAnchor),
            self.label.widthAnchor.constraint(equalTo: self.cellContainer.widthAnchor, multiplier: 0.9),
            
            self.divider.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            self.divider.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 8),
            self.divider.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.displayContent.centerYAnchor.constraint(equalTo: self.label.centerYAnchor),
            self.displayContent.rightAnchor.constraint(equalTo: self.cellContainer.rightAnchor)
        ])
    }
    
    // Need to specify height anchor for net progress view to make it show up correctly
    private func addNetProgressConstraints() {
        NSLayoutConstraint.activate([
            self.displayContent.heightAnchor.constraint(equalTo: self.heightAnchor),
            self.displayContent.widthAnchor.constraint(equalTo: self.cellContainer.widthAnchor, multiplier: 0.2)
        ])
    }
    
    // MARK: - Configurations
    public func configure(with viewModel: WorkoutGeneralStatsViewCellVM) {
        self.label.text = viewModel.displayTitle
        self.displayContent = viewModel.displayContent
        
        self.addSubview(self.displayContent)
        self.addConstraints()

        if !viewModel.displayDivider {
            self.divider.isHidden = true
        }
        
        if viewModel.type == .netProgress {
            self.addNetProgressConstraints()
        }
    }
    
}

//
//  WorkoutGeneralStatsViewCell.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/17/23.
//

import UIKit

final class WorkoutGeneralStatsViewCell: UITableViewCell {
    
    static let cellIdentifier = "WorkoutGeneralStatsViewCell"
    
    // Label for the row content
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail // Added truncation for notes
        return label
    }()
    
    // Divider between cells
    private let divider: UIView = {
        let divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .white
        return divider
    }()
    
    // Actual content to display on the right side
    private var displayContent: UIView = UIView()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear // Allows for customizability of cell
        
        self.configureClearSelectedBackground()
        self.addSubviews(label, divider)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
            self.label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75),
            
            self.divider.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            self.divider.heightAnchor.constraint(equalToConstant: 1),
            self.divider.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 8),
            self.divider.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.displayContent.centerYAnchor.constraint(equalTo: self.label.centerYAnchor),
            self.displayContent.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30)  
        ])
    }
    
    // Need to specify height anchor for net progress view to make it show up correctly
    private func addNetProgressConstraints() {
        NSLayoutConstraint.activate([
            self.displayContent.heightAnchor.constraint(equalTo: self.heightAnchor)
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

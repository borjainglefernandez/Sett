//
//  WorkoutGeneralStatsViewCell.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/17/23.
//

import UIKit

class WorkoutGeneralStatsViewCell: UITableViewCell {
    static let cellIdentifier = "WorkoutGeneralStatsViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private let divider: UIView = {
        let divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .white
        return divider
    }()
    
    private var displayContent: UIView = UIView()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear // Allows for customizability of cell

        let bgColorView = UIView()
        bgColorView.backgroundColor = .clear
        selectedBackgroundView = bgColorView
        
        addSubviews(label, divider)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initializer")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            
            divider.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            divider.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            displayContent.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            displayContent.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            
        ])
    }
    
    private func addViewConstraints() {
        NSLayoutConstraint.activate([
            displayContent.heightAnchor.constraint(equalTo: heightAnchor),
        ])
    }
    
    // MARK: - Configurations
    public func configure(with viewModel: WorkoutGeneralStatsViewCellViewModel) {
        label.text = viewModel.displayTitle
        self.displayContent = viewModel.displayContent
        addSubview(self.displayContent)
        addConstraints()

        if !viewModel.displayDivider {
            self.divider.isHidden = true
        }
        
        if viewModel.type == .netProgress {
            addViewConstraints()
        }
    }
    
    
}

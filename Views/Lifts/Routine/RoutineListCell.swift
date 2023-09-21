//
//  RoutineListViewCell.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 9/10/23.
//

import UIKit

class RoutineListCell: UITableViewCell {

    static let cellIdentifier = "RoutineListCell"

    // Each individual cell container
    private let containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .clear
        return containerView
    }()
    
    // Display title of the exercise
    private let titleLabel: UILabel = Label(title: "", fontSize: 12.0, weight: .regular)
    
    // Display type of the exercise
    private let workoutCountLabel: UILabel = Label(title: "", fontSize: 10.0, weight: .regular)
    
    // Arrow Icon
    private let arrowIconButton: UIButton = {
        let arrowIconButton = UIButton()
        arrowIconButton.translatesAutoresizingMaskIntoConstraints = false
        var config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 17, weight: .bold))
        arrowIconButton.tintColor = .label
        arrowIconButton.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        let iconImage = UIImage(systemName: "chevron.right")
        iconImage?.withTintColor(.label)
        arrowIconButton.setImage(iconImage, for: .normal)
        return arrowIconButton
    }()
    
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
        
        self.contentView.addSubviews(self.containerView, self.titleLabel, self.workoutCountLabel, self.arrowIconButton, self.divider)
        
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    override func prepareForReuse() {
        self.titleLabel.text = nil
        self.workoutCountLabel.text = nil
        self.divider.isHidden = false
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: self.topAnchor),
            self.containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.containerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.985),
            self.containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.985),   
            
            self.titleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 2),
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            
            self.workoutCountLabel.leftAnchor.constraint(equalTo: self.titleLabel.leftAnchor),
            self.workoutCountLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5),
            
            self.arrowIconButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.arrowIconButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            
            self.divider.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.95),
            self.divider.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.divider.heightAnchor.constraint(equalToConstant: 1),
            self.divider.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    // MARK: - Configurations
    public func configure(with viewModel: RoutineListCellVM, showDivider: Bool = true) {
        self.titleLabel.text = viewModel.routine.name
        
        var workoutCountLabelSuffix = "workout"
        if viewModel.routine.workouts?.count != 1 {
            workoutCountLabelSuffix += "s"
        }
        self.workoutCountLabel.text = "\(viewModel.routine.workouts?.count ?? 0) \(workoutCountLabelSuffix)"
        
        if !showDivider {
            self.divider.isHidden = true
        }
    }

}

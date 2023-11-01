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
        containerView.backgroundColor = .clear
        return containerView
    }()
    
    // Label for number of weight title
    private let weightTitleLabel: UILabel = Label(title: "Weight", fontSize: 11.0, weight: .light)
    
    // Text field for number of weight
    private let weightTextField: UITextField = {
        let weightTextField = UITextField()
        weightTextField.translatesAutoresizingMaskIntoConstraints = false
        weightTextField.tintColor = .label
        weightTextField.font = .systemFont(ofSize: 12, weight: .bold)
        weightTextField.placeholder = "0"
        weightTextField.keyboardType = .numberPad
        return weightTextField
    }()
    
    // Weight Input
    private let weightInput: NumberInputView = NumberInputView(title: "Weight")
    
    // Net Weight Input
    private let netWeightInput: NumberInputView = NumberInputView(title: "Net")
    
    // Reps Input
    private let repsInput: NumberInputView = NumberInputView(title: "Reps")
    
    // Net Reps Input
    private let netRepsInput: NumberInputView = NumberInputView(title: "Net")
    
    // Notes Input
    private let notesInput: SettNotesInput = SettNotesInput()
    
    // Divider
    private let divider: UIView = Divider()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear // Allows for customisability of cell
        self.configureClearSelectedBackground()
        
        self.contentView.addSubviews(self.containerView,
                                     self.weightInput,
                                     self.netWeightInput,
                                     self.repsInput,
                                     self.netRepsInput,
                                     self.notesInput,
                                     self.divider)
        
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.weightInput.prepareForReuse()
        self.repsInput.prepareForReuse()
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: self.topAnchor),
            self.containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.containerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.985),
            self.containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.985),
            
            self.weightInput.topAnchor.constraint(equalToSystemSpacingBelow: self.containerView.topAnchor, multiplier: 1),
            self.weightInput.leftAnchor.constraint(equalToSystemSpacingAfter: self.containerView.leftAnchor, multiplier: 2.5),
            self.weightInput.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),

            self.netWeightInput.leftAnchor.constraint(equalToSystemSpacingAfter: self.weightInput.rightAnchor, multiplier: 2),
            self.netWeightInput.centerYAnchor.constraint(equalTo: self.weightInput.centerYAnchor),
            self.netWeightInput.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),

            self.repsInput.leftAnchor.constraint(equalToSystemSpacingAfter: self.netWeightInput.rightAnchor, multiplier: 2.5),
            self.repsInput.centerYAnchor.constraint(equalTo: self.weightInput.centerYAnchor),
            self.repsInput.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),

            self.netRepsInput.leftAnchor.constraint(equalToSystemSpacingAfter: self.repsInput.rightAnchor, multiplier: 2.5),
            self.netRepsInput.centerYAnchor.constraint(equalTo: self.weightInput.centerYAnchor),
            self.netRepsInput.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
            
            self.notesInput.leftAnchor.constraint(equalToSystemSpacingAfter: self.netRepsInput.rightAnchor, multiplier: 2.5),
            self.notesInput.centerYAnchor.constraint(equalTo: self.weightInput.centerYAnchor),
            self.notesInput.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
            self.notesInput.rightAnchor.constraint(equalTo: self.containerView.rightAnchor),
            
            self.divider.widthAnchor.constraint(equalTo: self.containerView.widthAnchor, multiplier: 0.9),
            self.divider.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.divider.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    // MARK: - Configurations
    public func configure(with viewModel: SettListCellVM) {
        // TODO: CONFIGURE THIS JAUNT
        self.weightInput.setDelegate(delegate: viewModel.weightInputVM)
        if let weight = viewModel.sett.weight {
            self.weightInput.setNumber(number: weight)
        }
        self.repsInput.setDelegate(delegate: viewModel.repsInputVM)
        if let reps = viewModel.sett.reps {
            self.repsInput.setNumber(number: reps)
        }
        
    }

}

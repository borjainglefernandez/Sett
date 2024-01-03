//
//  SettListCell.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 10/17/23.
//

import UIKit

class SettListCell: UITableViewCell {
    
    static let cellIdentifier = "SettListCell"
    
    // View Models
    private var weightInputVM: WeightInputVM?
    private var repsInputVM: RepsInputVM?
    private var notesInputVM: SettNotesInputVM?

    // Each individual cell container
    private let containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
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
        weightTextField.keyboardType = .numberPad
        return weightTextField
    }()
    
    // Weight Input
    private let weightInput: NumberInputView = NumberInputView(title: "Weight")
    
    // Net Weight Label
    private let netWeightLabel: NumberLabelView = NumberLabelView(title: "Net")
    
    // Reps Input
    private let repsInput: NumberInputView = NumberInputView(title: "Reps")
    
    // Net Reps Label
    private let netRepsLabel: NumberLabelView = NumberLabelView(title: "Net")
    
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
                                     self.netWeightLabel,
                                     self.repsInput,
                                     self.netRepsLabel,
                                     self.notesInput,
                                     self.divider)
        
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.weightInputVM = nil
        self.weightInput.prepareForReuse()
        self.setNetWeight(to: "0")
        
        self.repsInputVM = nil
        self.repsInput.prepareForReuse()
        self.setNetReps(to: "0")
        
        self.notesInputVM = nil
        self.notesInput.prepareForReuse()
        self.setNotes(to: "")
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
            self.weightInput.widthAnchor.constraint(equalTo: self.containerView.widthAnchor, multiplier: 0.075),

            self.netWeightLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.weightInput.rightAnchor, multiplier: 2),
            self.netWeightLabel.centerYAnchor.constraint(equalTo: self.weightInput.centerYAnchor),
            self.netWeightLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
            self.netWeightLabel.widthAnchor.constraint(equalTo: self.weightInput.widthAnchor),

            self.repsInput.leftAnchor.constraint(equalToSystemSpacingAfter: self.netWeightLabel.rightAnchor, multiplier: 2.5),
            self.repsInput.centerYAnchor.constraint(equalTo: self.weightInput.centerYAnchor),
            self.repsInput.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
            self.repsInput.widthAnchor.constraint(equalTo: self.weightInput.widthAnchor),
            
            self.netRepsLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.repsInput.rightAnchor, multiplier: 2.5),
            self.netRepsLabel.centerYAnchor.constraint(equalTo: self.weightInput.centerYAnchor),
            self.netRepsLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
            self.netRepsLabel.widthAnchor.constraint(equalTo: self.weightInput.widthAnchor),
            
            self.notesInput.leftAnchor.constraint(equalToSystemSpacingAfter: self.netRepsLabel.rightAnchor, multiplier: 2.5),
            self.notesInput.centerYAnchor.constraint(equalTo: self.weightInput.centerYAnchor),
            self.notesInput.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
            
            self.divider.widthAnchor.constraint(equalTo: self.containerView.widthAnchor, multiplier: 0.9),
            self.divider.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.divider.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.notesInput.rightAnchor.constraint(equalTo: self.divider.rightAnchor)

        ])
    }
    
    // MARK: - Configurations
    public func configure(with viewModel: SettListCellVM) {
        
        // Configure weight input
        self.weightInputVM = WeightInputVM(sett: viewModel.sett, previousSett: viewModel.getPreviousSett(), setNetWeightLabel: self.setNetWeight)
        self.weightInput.setDelegate(delegate: weightInputVM!)
        if let weight = viewModel.sett.weight {
            self.weightInput.setNumber(number: weight)
        }
        
        // Configure reps input
        self.repsInputVM = RepsInputVM(sett: viewModel.sett, previousSett: viewModel.getPreviousSett(), setNetRepsLabel: self.setNetReps)
        self.repsInput.setDelegate(delegate: repsInputVM!)
        if let reps = viewModel.sett.reps {
            self.repsInput.setNumber(number: reps)
        }
        
        // Configure notes input
        self.notesInputVM = SettNotesInputVM(sett: viewModel.sett)
        self.notesInputVM!.setSettListCell(to: self)
        self.notesInput.configure(with: self.notesInputVM!)
        
        // Populate previous sett information
        let previousSett: Sett? = viewModel.getPreviousSett()
        if let previousSett = previousSett {
            if let previousWeight = previousSett.weight?.stringValue {
                weightInput.numberTextField.placeholder = previousWeight
            }
            
            if let previousReps = previousSett.reps?.stringValue {
                repsInput.numberTextField.placeholder = previousReps
            }
            
            if let previousNotes = previousSett.notes,
               !previousNotes.isEmpty {
                notesInput.notesTextField.placeholder = previousNotes
            }
        }
        
        // Configure net weight and reps
        if let netProgress = viewModel.sett.netProgress {
            
            // Net weight
            let netWeightLabel = NumberUtils.getNumWithSign(for: Int(netProgress.weight))
            self.setNetWeight(to: netWeightLabel)
            
            // Net reps
            let netRepsLabel = NumberUtils.getNumWithSign(for: Int(netProgress.reps))
            self.setNetReps(to: netRepsLabel)
        }
        
    }
    
    // MARK: - Actions
    public func setNotes(to notes: String?) {
        self.notesInput.setNotes(to: notes)
    }
    
    public func setNetWeight(to netWeight: String) {
        self.netWeightLabel.setNumberText(text: netWeight)
    }
    
    public func setNetReps(to netReps: String) {
        self.netRepsLabel.setNumberText(text: netReps)
    }

}

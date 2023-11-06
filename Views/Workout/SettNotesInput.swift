//
//  SettNotesInput.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 10/30/23.
//

import UIKit

class SettNotesInput: UIView {
    
    public var viewModel: SettNotesInputVM?

    // Title Label
    public let titleLabel: Label = Label(title: "Notes", fontSize: 11.0, weight: .light)
    
    // Text field for number of sets
    public let notesTextField: UITextField = {
        let notesTextField = UITextField()
        notesTextField.translatesAutoresizingMaskIntoConstraints = false
        notesTextField.tintColor = .label
        notesTextField.font = .systemFont(ofSize: 8, weight: .light)
        notesTextField.placeholder = "Add set notes..."
        return notesTextField
    }()
    
    // MARK: - Init
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .brown
        
        self.addSubviews(self.titleLabel, self.notesTextField)
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.notesTextField.topAnchor.constraint(equalToSystemSpacingBelow: self.titleLabel.bottomAnchor, multiplier: 0.25),
            self.notesTextField.leftAnchor.constraint(equalTo: self.titleLabel.leftAnchor)
//            self.notesTextField.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    
    // MARK: - Actions
    public func prepareForReuse() {
        self.titleLabel.text = nil
        self.notesTextField.text = nil
    }
    
    // MARK: - Setter
    public func configure(with viewModel: SettNotesInputVM) {
        self.viewModel = viewModel
    }
    
    public func setDelegate(delegate: UITextFieldDelegate) {
        self.notesTextField.delegate = delegate
    }
    
    public func setNotes(to notes: String?) {
        self.notesTextField.text = notes
    }
}

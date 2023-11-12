//
//  NumberInputView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 10/20/23.
//

import UIKit

class NumberInputView: UIView {
    
    // Title
    private let title: String
    
    // Title Label
    lazy var titleLabel: Label = Label(title: self.title, fontSize: 11.0, weight: .light)
    
    // Text field for number of sets
    public let numberTextField: UITextField = {
        let numberTextField = UITextField()
        numberTextField.translatesAutoresizingMaskIntoConstraints = false
        numberTextField.tintColor = .label
        numberTextField.font = .systemFont(ofSize: 12, weight: .bold)
        numberTextField.keyboardType = .numberPad
        return numberTextField
    }()
    
    // MARK: - Init
    init(frame: CGRect = .zero, title: String, placeholder: Int64 = 0) {
        self.title = title
        super.init(frame: frame)
        self.numberTextField.placeholder = "\(placeholder)"
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubviews(self.titleLabel, self.numberTextField)
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.numberTextField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            self.numberTextField.centerXAnchor.constraint(equalTo: self.titleLabel.centerXAnchor)
        ])
    }
    
    // MARK: - Actions
    public func prepareForReuse() {
        self.numberTextField.text = nil
        self.numberTextField.delegate = nil
    }
    
    // MARK: - Setter
    public func setNumber(number: NSNumber) {
        self.numberTextField.text = "\(number)"
    }
    
    public func setDelegate(delegate: UITextFieldDelegate) {
        self.numberTextField.delegate = delegate
    }
}

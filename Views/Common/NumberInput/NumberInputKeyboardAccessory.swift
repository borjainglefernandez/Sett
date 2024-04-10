//
//  NumberInputKeyboardAccessory.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 1/3/24.
//

import UIKit

class NumberInputKeyboardAccessory: UIToolbar {
    
    // MARK: - Properties
    lazy var backButton = {
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.backward"), style: .plain, target: nil, action: #selector(self.backButtonTapped))
        return backButton
    }()
    
    lazy var forwardButton = {
        let forwardButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.forward"), style: .plain, target: nil, action: #selector(self.forwardButtonTapped))
        return forwardButton
    }()
    
    lazy var checkMarkButton = {
        let checkMarkButton = UIBarButtonItem(
            image: UIImage(systemName: "checkmark"), style: .plain, target: nil, action: #selector(self.checkMarkButtonTapped))
        checkMarkButton.isEnabled = (self.currentTextField.text == nil || self.currentTextField.text == "")
            && (self.currentTextField.placeholder != nil && self.currentTextField.placeholder != "Add set notes...")
            
        return checkMarkButton
    }()
    
    lazy var keyboardDismissButton = UIBarButtonItem(
        image: UIImage(systemName: "keyboard.chevron.compact.down"), style: .plain, target: nil, action: #selector(self.dismissKeyboardButtonTapped))
    
    private let currentTextField: UITextField
    private let overallSuperView: UIView?

    // MARK: - Init
    init(frame: CGRect = .zero,
         currentTextField: UITextField,
         overallSuperView: UIView?) {
        self.overallSuperView = overallSuperView
        self.currentTextField = currentTextField
        super.init(frame: .init(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 44)))
        self.backgroundColor = .systemGray4
        
        forwardButton.tintColor = .systemCyan
        backButton.tintColor = .systemCyan
        checkMarkButton.tintColor = .systemCyan
        keyboardDismissButton.tintColor = .systemCyan

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        self.setItems([backButton, forwardButton, flexibleSpace, checkMarkButton, flexibleSpace, keyboardDismissButton], animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Button Actions
    @objc func backButtonTapped() {
        let previousTextField = self.currentTextField.findTextField(withTag: currentTextField.tag - 1, in: self.overallSuperView)
        previousTextField?.becomeFirstResponder()
    }
    
    @objc func forwardButtonTapped() {
        let nextTextField = self.currentTextField.findTextField(withTag: currentTextField.tag + 1, in: self.overallSuperView)
        nextTextField?.becomeFirstResponder()
    }
    
    @objc func checkMarkButtonTapped() {
        if let currentText = self.currentTextField.text,
           currentText.isEmpty {
            self.currentTextField.text = currentTextField.placeholder
        }
        let nextTextField = self.currentTextField.findTextField(withTag: currentTextField.tag + 1, in: self.overallSuperView)
        nextTextField?.becomeFirstResponder()
        self.updateButtonStates()
    }
    
    @objc func dismissKeyboardButtonTapped() {
        self.currentTextField.resignFirstResponder()
    }
    
    // MARK: - Helper
    public func updateButtonStates() {
        self.items?[0].isEnabled = self.backButton.isEnabled
        self.items?[2].isEnabled =  self.checkMarkButton.isEnabled
        self.items?[4].isEnabled =  self.forwardButton.isEnabled
    }
}

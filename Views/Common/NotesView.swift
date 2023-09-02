//
//  NotesView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/18/23.
//

import UIKit

final class NotesView: UIView {
    
    private let viewModel: NotesViewProtocol
    
    // Notes Text View
    public let textView: UITextView = {
        let textView = UITextView()
        textView.textColor = .black
        textView.backgroundColor = .white
        textView.font = .systemFont(ofSize: 17, weight: .regular)
        textView.layer.cornerRadius = 15
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return textView
    }()
    
    // MARK: - Init
    init(frame: CGRect, viewModel: NotesViewProtocol) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        self.backgroundColor = .systemCyan
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.textView.delegate = viewModel.getUITextViewDelegate()
    
        self.addSubviews(textView)
        self.configureTextView()
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.textView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            self.textView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            self.textView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            self.textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
        ])
    }
    
    // MARK: - Configure
    private func configureTextView() {
        if !self.viewModel.getNotes().isEmpty {
            self.textView.text = self.viewModel.getNotes()
        }
    }
}

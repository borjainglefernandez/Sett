//
//  NotesView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/18/23.
//

import UIKit

class NotesView: UIView {
    private let viewModel: WorkoutGeneralStatsViewCellViewModel
    
    public let textView: UITextView = {
        let textView = UITextView()
        textView.textColor = .black
        textView.backgroundColor = .white
        textView.font = .systemFont(ofSize: 17, weight: .regular)
        textView.layer.cornerRadius = 15
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // Add padding to the tex
        return textView
    }()
    
    // MARK: - Init
    init(frame: CGRect, viewModel: WorkoutGeneralStatsViewCellViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .systemCyan
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(textView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initializer")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            textView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            textView.rightAnchor.constraint(equalTo: rightAnchor, constant:-10),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
        ])
    }

}

//
//  WorkoutNotesSummaryView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/9/24.
//

import UIKit

class WorkoutNotesSummaryView: UIView {
    
    private let viewModel: WorkoutNotesSummaryVM
    var heightConstraint: NSLayoutConstraint!

    // Top bar of the general stats view container
    private let topBar: UIView = {
        let topBar = UIView()
        topBar.translatesAutoresizingMaskIntoConstraints = false
        topBar.backgroundColor = .systemGray4
        topBar.layer.cornerRadius = 15
        topBar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return topBar
    }()
    
    // Title label for top bar with notes
    public let titleLabel: UILabel = Label(frame: .zero, title: "Notes", fontSize: 14.0)

    // Notes Text View
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.textColor = self.traitCollection.userInterfaceStyle == .dark ? .white : .black
        textView.backgroundColor = self.traitCollection.userInterfaceStyle == .dark ? .black : .white
        textView.font = .systemFont(ofSize: 17, weight: .regular)
        textView.layer.cornerRadius = 15
        textView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return textView
    }()
    
    // MARK: - Init
    init(frame: CGRect = .zero, viewModel: WorkoutNotesSummaryVM) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubviews(self.topBar, self.titleLabel, self.textView)
        self.addConstraints()
        
        self.textView.delegate = viewModel.getUITextViewDelegate()
        self.configureTextView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.topBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.topBar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.topBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85),
            self.topBar.heightAnchor.constraint(equalToConstant: 30),
            
            self.titleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.topBar.leftAnchor, multiplier: 2),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            
            self.textView.leftAnchor.constraint(equalTo: self.topBar.leftAnchor),
            self.textView.rightAnchor.constraint(equalTo: self.topBar.rightAnchor),
            self.textView.topAnchor.constraint(equalTo: self.topBar.bottomAnchor),
            self.textView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor)
            // Create a height constraint and activate it
         
        ])
        self.heightConstraint = self.textView.heightAnchor.constraint(equalToConstant: 40) // Initial height
        self.heightConstraint.isActive = true

        // Observe content size changes
        self.textView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    // MARK: - Configure
    private func configureTextView() {
        if !self.viewModel.getNotes().isEmpty {
            self.textView.text = self.viewModel.getNotes()
        }
    }
    
    // Update the height constraint when the content size changes
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            let maxHeight = self.bounds.height - 10
            if let newSize = change?[.newKey] as? CGSize, maxHeight > 40 {
                self.heightConstraint.constant = min(newSize.height, maxHeight)
            }
        }
    }

    // Clean up the observer when the view controller is deallocated
    deinit {
        self.textView.removeObserver(self, forKeyPath: "contentSize")
    }
}

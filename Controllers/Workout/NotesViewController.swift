//
//  NotesViewController.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/18/23.
//

import UIKit

class NotesViewController: UIViewController {
    private let viewModel: WorkoutGeneralStatsViewCellViewModel

    private let topBar: UIView = {
        let topBar = UIView()
        topBar.translatesAutoresizingMaskIntoConstraints = false
        topBar.backgroundColor = .systemGray4
        topBar.layer.cornerRadius = 15
        return topBar
    }()
    
    private let closeButton: UIButton = {
        let closeButton = UIButton(type: .custom)
        let iconImage = UIImage(systemName: "xmark.circle.fill")
        let config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 17.0, weight: .bold))
        closeButton.tintColor = .systemCyan
        closeButton.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setImage(iconImage, for: .normal)
        return closeButton
    }()
    
    private let notesTitle: UITextField = {
        let notesTitle = UITextField()
        notesTitle.textColor = .label
        notesTitle.font = .systemFont(ofSize: 17, weight: .bold)
        notesTitle.translatesAutoresizingMaskIntoConstraints = false
        notesTitle.text = "Notes"
        return notesTitle
    }()
    
    private let notesView: NotesView
    

    
    // MARK: - Init
    init(viewModel: WorkoutGeneralStatsViewCellViewModel) {
        self.viewModel = viewModel
        notesView = NotesView(frame: .zero, viewModel: self.viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initializer")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        view.addSubviews(self.topBar, self.closeButton, self.notesTitle, self.notesView)
        addConstraints()
        self.notesView.textView.becomeFirstResponder()
        self.closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)


    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.topBar.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            self.topBar.widthAnchor.constraint(equalTo:view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.95),
            self.topBar.heightAnchor.constraint(equalToConstant: 30),
            
            self.notesTitle.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            self.notesTitle.centerXAnchor.constraint(equalTo: topBar.centerXAnchor),
            
            self.closeButton.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            self.closeButton.leftAnchor.constraint(equalTo: topBar.rightAnchor, constant: -7),
            
            self.notesView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            self.notesView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            self.notesView.topAnchor.constraint(equalTo: topBar.bottomAnchor),
            self.notesView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    // MARK: - Actions
    @objc func close() {
        self.dismiss(animated: true)
    }
}

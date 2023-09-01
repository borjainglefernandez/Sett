//
//  SelectExerciseModalViewController.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/31/23.
//

import UIKit

class SelectExerciseModalViewController: UIViewController {
    
    private let viewModel: SelectExerciseModalViewModel
    private let routine: Routine
    private let category: Category
    
    // Cancel Button
    private let cancelButton: UIButton = IconButton(frame: .zero, imageName: "x.circle.fill")
    
    // Modal Title
    private let titleLabel: Label = Label(title: "Exercise Selection")
    
    private let selectExerciseModal: SelectExerciseModal
    
    // MARK: - Init
    init(routine: Routine, category: Category) {
        self.routine = routine
        self.category = category
        self.viewModel = SelectExerciseModalViewModel(routine: routine, category: category)
        self.selectExerciseModal = SelectExerciseModal(viewModel: self.viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        self.view.backgroundColor = .systemGray6
        
        self.cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        self.view.addSubviews(self.cancelButton, self.titleLabel, self.selectExerciseModal)
        self.addConstraints()
        super.viewDidLoad()
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.cancelButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 30),
            self.cancelButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.cancelButton.centerYAnchor),
            
            self.selectExerciseModal.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 30),
            self.selectExerciseModal.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.selectExerciseModal.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.selectExerciseModal.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
    // MARK: - Actions
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }

}
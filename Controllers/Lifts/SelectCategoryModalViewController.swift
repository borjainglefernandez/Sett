//
//  SelectCategoryModalViewController.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/29/23.
//

import UIKit

class SelectCategoryModalViewController: UIViewController {
    
    private let viewModel: SelectCategoryModalViewModel
    private let routine: Routine
    
    // Cancel Button
    private let cancelButton: UIButton = IconButton(frame: .zero, imageName: "x.circle.fill")
    
    // Modal Title
    private let titleLabel: Label = Label(title: "Category Selection")
    
    private let selectCategoryModal: SelectCategoryModal
    
    // MARK: - Init
    init(routine: Routine) {
        self.routine = routine
        self.viewModel = SelectCategoryModalViewModel(routine: routine)
        self.selectCategoryModal = SelectCategoryModal(viewModel: self.viewModel)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemGray6
        
        self.cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        self.view.addSubviews(self.cancelButton, self.titleLabel, self.selectCategoryModal)
        self.addConstraints()
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.cancelButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 30),
            self.cancelButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.cancelButton.centerYAnchor),
            
            self.selectCategoryModal.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 30),
            self.selectCategoryModal.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.selectCategoryModal.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.selectCategoryModal.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
    // MARK: - Actions
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }

}

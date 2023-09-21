//
//  IndividualExerciseModalViewController.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/13/23.
//

import UIKit

class IndividualExerciseModalViewController: UIViewController {
    
    private let viewModel: IndividualExerciseModalVM
    private let category: Category
    private let exercise: Exercise?
    
    // Cancel Button
    private let cancelButton: UIButton = IconButton(frame: .zero, imageName: "x.circle.fill")
    
    // Confirm Button
    private let confirmButton: UIButton = IconButton(frame: .zero, imageName: "checkmark.circle")
    
    // Exercise name text field
    lazy var exerciseNameTextField: UITextField = {
        let exerciseNameTextField = UITextField()
        exerciseNameTextField.textColor = .label
        exerciseNameTextField.font = .systemFont(ofSize: 17, weight: .bold)
        exerciseNameTextField.translatesAutoresizingMaskIntoConstraints = false
        exerciseNameTextField.delegate = self.viewModel
        exerciseNameTextField.becomeFirstResponder()
        return exerciseNameTextField
    }()
    
    private let individualExerciseModal: IndividualExerciseModal
    
    // MARK: - Init
    init(category: Category, exercise: Exercise? = nil) {
        self.category = category
        self.exercise = exercise
        self.viewModel = IndividualExerciseModalVM(category: category, exercise: exercise)
        self.individualExerciseModal = IndividualExerciseModal(viewModel: self.viewModel)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardWhenTapOutside()

        self.view.backgroundColor = .systemGray6
        
        self.cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        self.confirmButton.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        self.view.addSubviews(self.cancelButton, self.exerciseNameTextField, self.confirmButton, self.individualExerciseModal)
        self.addConstraints()
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.cancelButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 30),
            self.cancelButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            self.exerciseNameTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.exerciseNameTextField.centerYAnchor.constraint(equalTo: self.cancelButton.centerYAnchor),
            
            self.confirmButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -30),
            self.confirmButton.centerYAnchor.constraint(equalTo: self.exerciseNameTextField.centerYAnchor),
            
            self.individualExerciseModal.topAnchor.constraint(equalTo: self.exerciseNameTextField.bottomAnchor, constant: 30),
            self.individualExerciseModal.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.individualExerciseModal.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.individualExerciseModal.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    // MARK: - Actions
    @objc func cancel() {
        self.viewModel.cancel()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func confirm() {
        let errorMessage = self.viewModel.confirm()
        if !errorMessage.isEmpty {
            // Controller
            let incompleteExerciseAlertController = UIAlertController(title: "Exercise Issue", message: errorMessage, preferredStyle: .alert)
            
            incompleteExerciseAlertController.addAction(UIAlertAction(title: "Try Again", style: .default))
            
            self.present(incompleteExerciseAlertController, animated: true)
            return
        }
        self.dismiss(animated: true, completion: nil)
    }
}

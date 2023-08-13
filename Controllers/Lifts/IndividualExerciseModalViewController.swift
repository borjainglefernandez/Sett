//
//  IndividualExerciseModalViewController.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/13/23.
//

import UIKit

class IndividualExerciseModalViewController: UIViewController {
    
    private let category: Category
    private let exercise: Exercise?
    private let individualExerciseModal: IndividualExerciseModal
    
    // MARK: - Init
    init(category: Category, exercise: Exercise? = nil) {
        self.category = category
        self.exercise = exercise
        let viewModel: IndividualExerciseModalViewModel = IndividualExerciseModalViewModel(category: category, exercise: exercise)
        self.individualExerciseModal = IndividualExerciseModal(viewModel: viewModel)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemGray6
        
        self.view.addSubviews(self.individualExerciseModal)
        self.addConstraints()
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.individualExerciseModal.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.individualExerciseModal.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.individualExerciseModal.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.individualExerciseModal.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
}

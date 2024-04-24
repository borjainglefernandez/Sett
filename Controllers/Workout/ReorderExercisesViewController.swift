//
//  ViewController.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 3/20/24.
//

import UIKit

class ReorderExercisesViewController: UIViewController {
    private let workout: Workout
    
    private let topBar: MenuBar = MenuBar(frame: .zero)
    private let confirmButton: UIButton = IconButton(frame: .zero, imageName: "checkmark.circle.fill")

    lazy var workoutName: Label = Label(title: self.workout.title ?? "Reorder Exercises")
    lazy var reorderExercisesVM: ReorderExercisesVM = ReorderExercisesVM(workout: self.workout)
    lazy var reorderExercisesView: ReorderExercisesView = {
        let reorderExercisesView = ReorderExercisesView(viewModel: self.reorderExercisesVM)
        return reorderExercisesView
    }()

    // MARK: - Init
    init(workout: Workout) {
        self.workout = workout
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardWhenTapOutside()
        
        self.view.backgroundColor = .systemCyan
        
        self.topBar.addSubviews(self.workoutName, self.confirmButton)
        
        self.view.addSubviews(self.topBar, reorderExercisesView)
        self.addConstraints()
        
        self.confirmButton.addTarget(self, action: #selector(self.confirm), for: .touchUpInside)

    }

    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.topBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.topBar.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.topBar.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.95),
                        
            self.workoutName.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            self.workoutName.centerXAnchor.constraint(equalTo: self.topBar.centerXAnchor),
            
            self.confirmButton.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            self.confirmButton.rightAnchor.constraint(equalTo: self.topBar.rightAnchor, constant: -7),
            
            self.reorderExercisesView.topAnchor.constraint(equalTo: self.topBar.bottomAnchor, constant: 7),
            self.reorderExercisesView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.reorderExercisesView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            self.reorderExercisesView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Actions
    @objc func confirm() {
        self.reorderExercisesVM.confirmChanges()
        self.dismiss(animated: true)
    }

}

//
//  LiftsViewController.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/7/23.
//

import UIKit

final class LiftsViewController: UIViewController {
    
    private let topBar = MenuBar(frame: .zero)
    
    // Title label for currently selected feed
    lazy var titleLabel: UILabel = Label(frame: .zero, title: self.routineExerciseMenuViewModel.mainMenuTitle)
    
    // Button to change between routines and exercises
    private let addButton: UIButton = IconButton(frame: .zero, imageName: "plus.circle")
    
    // Button to change menus
    private let changeMenuButton: UIButton = IconButton(frame: .zero, imageName: "arrowtriangle.down.fill", color: .label, fontSize: 12.0)
    
    private let routineExerciseMenuViewModel: RoutineExerciseMenuViewModel = RoutineExerciseMenuViewModel()
    
    private let routinesView: RoutinesView = RoutinesView()
    private let exercisesView: ExercisesView = ExercisesView()
    
    
    private func setUpRoutineOrCategoryMenu() {
        self.changeMenuButton.showsMenuAsPrimaryAction = true
        
        let changeWorkoutLabel = UIAction(title: self.routineExerciseMenuViewModel.changeMenuTitle, attributes: [], state: .off) { action in
            self.routineExerciseMenuViewModel.toggleType()
            self.titleLabel.text = self.routineExerciseMenuViewModel.mainMenuTitle
            self.setUpRoutineOrCategoryMenu()
            self.setUpContent()
        }
        
        self.changeMenuButton.menu = UIMenu(children: [changeWorkoutLabel])
    }
    
    private func setUpContent() {
        switch self.routineExerciseMenuViewModel.type {
        case .routine:
            self.routinesView.isHidden = false
            self.exercisesView.isHidden = true
            self.setUpAddRoutineButton()
        case .exercise:
            self.routinesView.isHidden = true
            self.exercisesView.isHidden = false
            self.setUpAddCategoryButton()
            
        }
    }
    
    private func setUpAddCategoryButton() {
        if let target = self.addButton.allTargets.first as? NSObject {
            self.addButton.removeTarget(target, action: #selector(addRoutine), for: .touchUpInside)
        }
        self.addButton.addTarget(self, action: #selector(addCategory), for: .touchUpInside)
    }
    
    private func setUpAddRoutineButton() {
        if let target = self.addButton.allTargets.first as? NSObject {
            self.addButton.removeTarget(target, action: #selector(addCategory), for: .touchUpInside)
        }
        self.addButton.addTarget(self, action: #selector(addRoutine), for: .touchUpInside)
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemCyan
        
        self.setUpContent()
        self.setUpRoutineOrCategoryMenu()
        
        self.view.addSubviews(topBar, titleLabel, changeMenuButton, addButton, routinesView, exercisesView)
        self.addConstraints()
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.topBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.topBar.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.topBar.heightAnchor.constraint(equalToConstant: 30),
            self.topBar.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.95),
            
            self.titleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.topBar.leftAnchor, multiplier: 2),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            
            self.changeMenuButton.leftAnchor.constraint(equalTo: self.titleLabel.rightAnchor, constant: 8),
            self.changeMenuButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
            
            self.addButton.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            self.addButton.rightAnchor.constraint(equalTo: self.topBar.rightAnchor, constant: -15),

            self.routinesView.topAnchor.constraint(equalTo: topBar.bottomAnchor),
            self.routinesView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.routinesView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            self.routinesView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            self.exercisesView.topAnchor.constraint(equalTo: topBar.bottomAnchor),
            self.exercisesView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.exercisesView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            self.exercisesView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)

        ])
    }
    
    // MARK: - Actions
    @objc func addRoutine() {

    }
    
    @objc func addCategory() {
        let alertController = UIAlertController(title: "Create new category?", message: nil, preferredStyle: .alert)
         
        let addCategoryViewModel: AddCategoryViewModel = AddCategoryViewModel(alertController: alertController)
         alertController.addTextField { textField in
             textField.placeholder = "New category name"
             textField.delegate = addCategoryViewModel
         }
         
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
             addCategoryViewModel.createNewCategory()
         }
         
         let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
         
         okAction.isEnabled = false
         alertController.addAction(okAction)
         alertController.addAction(cancelAction)
         
         present(alertController, animated: true, completion: nil)
    }
    
    public func addExercise(category: Category, exercise: Exercise? = nil) {
        // Create new exercise if needed
        if let exercise = exercise {
//            let newExercise = Exercise(context: CoreDataBase.context)
//            newExercise.name = "New Exercise"
//            CoreDataBase.save()
            print("No Exercise")
        }
      
        
        // Navigate to new workout screen
        let individualExerciseModalViewController = IndividualExerciseModalViewController(category: category, exercise: exercise)
        individualExerciseModalViewController.isModalInPresentation = true // Disable dismissing of modal
        self.present(individualExerciseModalViewController, animated: true)
    }
}

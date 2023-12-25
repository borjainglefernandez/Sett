//
//  RoutineExerciseListCell.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/28/23.
//

import UIKit

class RoutineExerciseListCell: UICollectionViewCell {

    static let cellIdentifier = "RoutineExerciseListCell"
    private var routineExerciseListCellVM: RoutineExerciseListCellVM?
    private var workoutExerciseNotesVM: WorkoutExerciseNotesVM?
    
    // Top menu bar
    private let menuBar = MenuBar(maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    
    // Title label
    private let titleLabel = Label(title: "", fontSize: 14)
    
    // Icon for the exercise type
    private let exerciseTypeIcon = IconButton(imageName: "dumbbell.fill", color: .label, fontSize: 14)
    
    // Exercise container
    private let exerciseContainer: UIView = {
        let exerciseContainer = UIView()
        exerciseContainer.backgroundColor = .systemGray3.withAlphaComponent(0.44)
        exerciseContainer.translatesAutoresizingMaskIntoConstraints = false
        exerciseContainer.layer.cornerRadius = 15
        exerciseContainer.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return exerciseContainer
    }()
    
    // Set Input
    private let setInput: NumberInputView = NumberInputView(title: "Sets")
    
    // Label for notes title
    private let notesTitleLabel: UILabel = Label(title: "Notes", fontSize: 11.0, weight: .light)
    
    // Text field for notes
    lazy var notesTextField: UITextField = {
        let notesTextField = UITextField()
        notesTextField.translatesAutoresizingMaskIntoConstraints = false
        notesTextField.tintColor = .label
        notesTextField.font = self.notesTitleLabel.font
        notesTextField.placeholder = "Add cues, reminders, or anything else!"
        return notesTextField
    }()
    
    // More button
    private let moreButton = IconButton(imageName: "ellipsis", color: .label, fontSize: 14)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.layer.cornerRadius = 15
        
        self.setUpMoreButton()
        
        self.menuBar.addSubviews(self.exerciseTypeIcon, self.moreButton)
        self.exerciseContainer.addSubviews(self.setInput, self.notesTitleLabel, self.notesTextField)
        self.addSubviews(self.menuBar, self.titleLabel, self.exerciseContainer)
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported constructor")
    }
    
    // MARK: - LifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
        self.setInput.prepareForReuse()
        self.notesTextField.text = nil
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.menuBar.topAnchor.constraint(equalTo: self.topAnchor),
            self.menuBar.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.menuBar.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            self.titleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 2),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.menuBar.centerYAnchor),
            
            self.exerciseTypeIcon.leftAnchor.constraint(equalTo: self.titleLabel.rightAnchor, constant: 5),
            self.exerciseTypeIcon.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
            
            self.exerciseContainer.topAnchor.constraint(equalTo: self.menuBar.bottomAnchor),
            self.exerciseContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.exerciseContainer.widthAnchor.constraint(equalTo: self.menuBar.widthAnchor),
            self.exerciseContainer.heightAnchor.constraint(equalTo: self.menuBar.heightAnchor, multiplier: 1.5),
            
            self.setInput.topAnchor.constraint(equalTo: self.exerciseContainer.topAnchor, constant: 5),
            self.setInput.leftAnchor.constraint(equalTo: self.exerciseContainer.leftAnchor, constant: 25),
            self.setInput.bottomAnchor.constraint(equalTo: self.exerciseContainer.bottomAnchor),
            
            self.notesTitleLabel.centerYAnchor.constraint(equalTo: self.setInput.titleLabel.centerYAnchor),
            self.notesTitleLabel.leftAnchor.constraint(equalTo: self.setInput.titleLabel.rightAnchor, constant: 30),
            
            self.notesTextField.leftAnchor.constraint(equalTo: self.notesTitleLabel.leftAnchor),
            self.notesTextField.centerYAnchor.constraint(equalTo: self.setInput.numberTextField.centerYAnchor),
            self.notesTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            
            self.moreButton.rightAnchor.constraint(equalTo: self.menuBar.rightAnchor, constant: -20),
            self.moreButton.centerYAnchor.constraint(equalTo: self.menuBar.centerYAnchor)
        ])
    }
    
    // MARK: - Configurations
    public func configure(with viewModel: RoutineExerciseListCellVM) {
        self.routineExerciseListCellVM = viewModel
        self.titleLabel.text = viewModel.workoutExercise.exercise?.name
        
        if let iconImage = viewModel.workoutExercise.exercise?.type?.exerciseType.icon() {
            iconImage.withTintColor(.label)
            self.exerciseTypeIcon.setImage(iconImage, for: .normal)
        }
       
        self.setInput.setNumber(number: NSNumber(value: viewModel.workoutExercise.numSetts))
        self.setInput.setDelegate(delegate: viewModel)
        
        self.notesTextField.text = viewModel.workoutExercise.notes
        self.workoutExerciseNotesVM = WorkoutExerciseNotesVM(workoutExercise: viewModel.workoutExercise)
        self.notesTextField.delegate = self.workoutExerciseNotesVM
    }
    
    private func setUpMoreButton() {
        let replaceWorkoutExerciseAction = UIAction(
            title: "Replace Exercise",
            image: UIImage(systemName: "arrow.2.squarepath"),
            attributes: [],
            state: .off) { _ in
            self.routineExerciseListCellVM?.deleteWorkoutExercise()
            if let parentViewController = self.getParentViewController(self),
               let routineExerciseListCellVM = self.routineExerciseListCellVM {
                let selectCategoryRoutineVM = SelectCategoryRoutineVM(routine: routineExerciseListCellVM.routine)
                let selectCategoryModalViewController =
                    SelectCategoryModalViewController(
                        viewModel: selectCategoryRoutineVM)
                parentViewController.present(selectCategoryModalViewController, animated: true)
            }
        }
        
        let deleteWorkoutExerciseAction = UIAction(
            title: "Delete Exercise",
            image: UIImage(systemName: "trash"),
            attributes: [.destructive],
            state: .off) { _ in
            
            self.routineExerciseListCellVM?.deleteWorkoutExercise()
        }
        
        self.moreButton.showsMenuAsPrimaryAction = true
        self.moreButton.menu =  UIMenu(preferredElementSize: .medium, children: [replaceWorkoutExerciseAction, deleteWorkoutExerciseAction])
    }
}

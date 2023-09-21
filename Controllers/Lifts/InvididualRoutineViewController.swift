//
//  RoutineViewController.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/28/23.
//

import UIKit

class IndividualRoutineViewController: UIViewController {
    private let viewModel: IndividualRoutineVM
    
    private let topBar: MenuBar = MenuBar(frame: .zero)
    private let backButton: UIButton = IconButton(frame: .zero, imageName: "arrow.backward.circle.fill")
    private let moreButton: UIButton = IconButton(frame: .zero, imageName: "ellipsis.circle.fill")

    lazy var routineName: UITextField = {
        let routineName = UITextField()
        routineName.textColor = .label
        routineName.font = .systemFont(ofSize: 17, weight: .bold)
        routineName.translatesAutoresizingMaskIntoConstraints = false
        routineName.text = self.viewModel.routine.name
        routineName.delegate = self.viewModel
        return routineName
    }()
    
    private let routineExerciseList: RoutineExerciseList
    
    // MARK: - Init
    init(viewModel: IndividualRoutineVM) {
        self.viewModel = viewModel
        self.routineExerciseList = RoutineExerciseList(viewModel: RoutineExerciseListVM(routine: self.viewModel.routine))
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardWhenTapOutside()
        
        self.view.backgroundColor = .systemCyan
        
        self.topBar.addSubviews(self.backButton, self.routineName, self.moreButton)
        self.view.addSubviews(self.topBar, self.routineExerciseList)
        self.addConstraints()
        
        self.backButton.addTarget(self, action: #selector(self.goBack), for: .touchUpInside)

    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.topBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.topBar.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.topBar.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.95),
            
            self.backButton.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            self.backButton.leftAnchor.constraint(equalTo: self.topBar.leftAnchor, constant: 7),
            
            self.routineName.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            self.routineName.centerXAnchor.constraint(equalTo: self.topBar.centerXAnchor),
            
            self.moreButton.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            self.moreButton.rightAnchor.constraint(equalTo: self.topBar.rightAnchor, constant: -7),
            
            self.routineExerciseList.topAnchor.constraint(equalTo: self.topBar.bottomAnchor),
            self.routineExerciseList.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.routineExerciseList.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            self.routineExerciseList.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Actions
    @objc func goBack() {
        self.dismiss(animated: true)
    }
}

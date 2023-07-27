//
//  LiftsViewController.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/7/23.
//

import UIKit

final class LiftsViewController: UIViewController {
    
    private let topBar = TopBar(frame: .zero)
    
    // Title label for currently selected feed
    lazy var titleLabel: UILabel = TitleLabel(frame: .zero, title: self.routineExerciseMenuViewModel.mainMenuTitle)
    
    // Button to change between routines and exercises
    private let addButton: UIButton = IconButton(frame: .zero, imageName: "plus.circle")
    
    // Button to change menus
    private let changeMenuButton: UIButton = IconButton(frame: .zero, imageName: "arrowtriangle.down.fill", color: .white, fontSize: 12.0)
    
    private let routineExerciseMenuViewModel: RoutineExerciseMenuViewModel = RoutineExerciseMenuViewModel()
    
    private func setUpMenu() {
        self.changeMenuButton.showsMenuAsPrimaryAction = true
        
        let changeWorkoutLabel = UIAction(title: self.routineExerciseMenuViewModel.changeMenuTitle, attributes: [], state: .off) { action in
            self.routineExerciseMenuViewModel.toggleType()
            self.titleLabel.text = self.routineExerciseMenuViewModel.mainMenuTitle
            self.setUpMenu()
        }
        
        self.changeMenuButton.menu = UIMenu(children: [changeWorkoutLabel])
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemCyan
        
        self.setUpMenu()
        
        self.view.addSubviews(topBar, titleLabel, changeMenuButton, addButton)
        self.addConstraints()
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.topBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.topBar.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.topBar.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.95),
            
            self.titleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.topBar.leftAnchor, multiplier: 2),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            
            self.changeMenuButton.leftAnchor.constraint(equalTo: self.titleLabel.rightAnchor, constant: 8),
            self.changeMenuButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
            
            self.addButton.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            self.addButton.rightAnchor.constraint(equalTo: self.topBar.rightAnchor, constant: -15),
        ])
    }
}

enum RoutineExerciseMenuSelection: CaseIterable {
    case routine
    case exercise
    
    var displayTitle: String {
        switch self {
        case .routine:
            return "Routines"
        case .exercise:
            return "Exercises"
        }
    }
    
}

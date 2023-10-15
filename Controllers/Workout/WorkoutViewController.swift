//
//  WorkoutViewController.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/14/23.
//

import UIKit
import SwiftUI

final class WorkoutViewController: UIViewController {
    private let viewModel: WorkoutVM
    private let workoutGeneralStatsView: WorkoutGeneralStatsView
    let workoutExerciseListView: some View = WorkoutExerciseListView().environment(\.managedObjectContext, CoreDataBase.context)
    lazy var workoutExerciseListViewHC: UIHostingController<some View> = UIHostingController(rootView: self.workoutExerciseListView)
    
    private let topBar: MenuBar = MenuBar(frame: .zero)
    private let backButton: UIButton = IconButton(frame: .zero, imageName: "arrow.backward.circle.fill")
    private let moreButton: UIButton = IconButton(frame: .zero, imageName: "ellipsis.circle.fill")

    lazy var workoutName: UITextField = {
        let workoutName = UITextField()
        workoutName.textColor = .label
        workoutName.font = .systemFont(ofSize: 17, weight: .bold)
        workoutName.translatesAutoresizingMaskIntoConstraints = false
        workoutName.text = self.viewModel.workout.title
        workoutName.delegate = self.viewModel
        return workoutName
    }()

    // MARK: - Init
    init(viewModel: WorkoutVM) {
        self.viewModel = viewModel
        self.workoutGeneralStatsView = WorkoutGeneralStatsView(frame: .zero, viewModel: self.viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardWhenTapOutside()
        
        // Add Swift UI Components
        self.addChild(workoutExerciseListViewHC)
        self.workoutExerciseListViewHC.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(workoutExerciseListViewHC.view)
        
        self.view.backgroundColor = .systemCyan
        
        self.topBar.addSubviews(backButton, self.workoutName, self.moreButton)
        self.view.addSubviews(topBar, workoutGeneralStatsView)
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
            
            self.workoutName.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            self.workoutName.centerXAnchor.constraint(equalTo: self.topBar.centerXAnchor),
            
            self.moreButton.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            self.moreButton.rightAnchor.constraint(equalTo: self.topBar.rightAnchor, constant: -7),
            
            self.workoutGeneralStatsView.topAnchor.constraint(equalTo: self.topBar.bottomAnchor),
            self.workoutGeneralStatsView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.workoutGeneralStatsView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            self.workoutGeneralStatsView.heightAnchor.constraint(equalToConstant: 285),
            
            self.workoutExerciseListViewHC.view.topAnchor.constraint(equalTo: self.workoutGeneralStatsView.bottomAnchor, constant: 10),
            self.workoutExerciseListViewHC.view.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.workoutExerciseListViewHC.view.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            self.workoutExerciseListViewHC.view.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            
        ])
    }
    
    // MARK: - Actions
    @objc func goBack() {
        self.dismiss(animated: true)
    }
}

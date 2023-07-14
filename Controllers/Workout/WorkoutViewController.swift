//
//  WorkoutViewController.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/14/23.
//

import UIKit

class WorkoutViewController: UIViewController {
    private let viewModel: WorkoutViewModel

    private let workoutView: WorkoutView
    
    private let topBar: UIView = {
        let topBar = UIView()
        topBar.translatesAutoresizingMaskIntoConstraints = false
        topBar.backgroundColor = .systemGray4
        topBar.layer.cornerRadius = 15
        return topBar
    }()
    
    private let backButton: UIButton = {
        let backButton = UIButton(type: .custom)
        let iconImage = UIImage(systemName: "arrow.backward.circle.fill")
        var config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 17.0, weight: .bold))
        backButton.tintColor = .systemCyan
        backButton.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(iconImage, for: .normal)
        return backButton
    }()
    
    private let workoutName: UITextField = {
        let workoutName = UITextField()
        workoutName.textColor = .label
        workoutName.font = .systemFont(ofSize: 17, weight: .bold)
        workoutName.translatesAutoresizingMaskIntoConstraints = false
        return workoutName
    }()
    
    
    private let moreButton: UIButton = {
        let moreButton = UIButton(type: .custom)
        let iconImage = UIImage(systemName: "ellipsis.circle.fill")
        var config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 17.0, weight: .bold))
        moreButton.tintColor = .systemCyan
        moreButton.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        moreButton.setImage(iconImage, for: .normal)
        return moreButton
    }()
    
    // MARK: - Init
    init(viewModel: WorkoutViewModel) {
        self.viewModel = viewModel
        self.workoutView = WorkoutView(frame: .zero, viewModel: self.viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initializer")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        self.workoutName.text = self.viewModel.workout.title
        topBar.addSubviews(backButton, self.workoutName, self.moreButton)
        view.addSubviews(topBar, workoutView)
        self.addConstraints()

    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.topBar.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            self.topBar.widthAnchor.constraint(equalTo:view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.95),
            self.topBar.heightAnchor.constraint(equalToConstant: 30),
            
            self.backButton.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            self.backButton.leftAnchor.constraint(equalTo: topBar.leftAnchor, constant: 7),
            
            self.workoutName.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            self.workoutName.centerXAnchor.constraint(equalTo: topBar.centerXAnchor),
            
            self.moreButton.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            self.moreButton.rightAnchor.constraint(equalTo: topBar.rightAnchor,  constant: -7),
            
            self.workoutView.topAnchor.constraint(equalTo: topBar.bottomAnchor),
            self.workoutView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            self.workoutView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            self.workoutView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
    // MARK: - Actions
    @objc func goBack() {
        self.dismiss(animated: true)
    }
}

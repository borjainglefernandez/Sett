//
//  RoutineExerciseListCell.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/28/23.
//

import UIKit

class RoutineExerciseListCell: UICollectionViewCell {

    static let cellIdentifier = "RoutineExerciseListCell"
    private var viewModel: RoutineExerciseListCellViewModel?
    
    // Top menu bar
    private let menuBar = MenuBar(maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    
    // Title label
    private let titleLabel = Label(title: "", fontSize: 14)
    
    // Exercise container
    private let exerciseContainer: UIView = {
        let exerciseContainer = UIView()
        exerciseContainer.backgroundColor = .systemGray3.withAlphaComponent(0.44)
        exerciseContainer.translatesAutoresizingMaskIntoConstraints = false
        exerciseContainer.layer.cornerRadius = 15
        exerciseContainer.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return exerciseContainer
    }()
    
    // Label for number of sets title
    private let setsTitleLabel: UILabel = Label(title: "Sets", fontSize: 11.0, weight: .light)
    
    private let setsTextField: UITextField = {
        let setsTextField = UITextField()
        setsTextField.translatesAutoresizingMaskIntoConstraints = false
        setsTextField.tintColor = .label
        setsTextField.font = .systemFont(ofSize: 12, weight: .bold)
        setsTextField.placeholder = "0"
        setsTextField.keyboardType = .numberPad
        return setsTextField
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.layer.cornerRadius = 15
        
        self.exerciseContainer.addSubviews(self.setsTitleLabel, self.setsTextField)
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
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.menuBar.topAnchor.constraint(equalTo: self.topAnchor),
            self.menuBar.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.menuBar.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            self.titleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 2),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.menuBar.centerYAnchor),
            
            self.exerciseContainer.topAnchor.constraint(equalTo: self.menuBar.bottomAnchor),
            self.exerciseContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.exerciseContainer.widthAnchor.constraint(equalTo: self.menuBar.widthAnchor),
            self.exerciseContainer.heightAnchor.constraint(equalTo: self.menuBar.heightAnchor, multiplier: 1.5),
            
            self.setsTitleLabel.topAnchor.constraint(equalTo: self.exerciseContainer.topAnchor, constant: 5),
            self.setsTitleLabel.leftAnchor.constraint(equalTo: self.exerciseContainer.leftAnchor, constant: 25),
            
            self.setsTextField.topAnchor.constraint(equalTo: self.setsTitleLabel.bottomAnchor),
            self.setsTextField.centerXAnchor.constraint(equalTo: self.setsTitleLabel.centerXAnchor)
        ])
    }
    
    // MARK: - Configurations
    public func configure(with viewModel: RoutineExerciseListCellViewModel) {
        self.titleLabel.text = viewModel.workoutExercise.exercise?.name
        self.setsTextField.text = "\(viewModel.workoutExercise.numSetts)"
        setsTextField.delegate = viewModel
    }
    
    
}

//
//  ReorderExercisesCellTableViewCell.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 3/20/24.
//

import UIKit

class ReorderExercisesCell: UITableViewCell {
    
    static let cellIdentifier = "ReorderExercisesCellTableViewCell"
    
    private var viewModel: ReorderExercisesCellVM?
    
    private let exerciseNameLabel: Label = Label(title: "")
    
    private let containerView: UIView = {
       let containerView = UIView()
        containerView.backgroundColor = .systemGray4
        containerView.layer.cornerRadius = 15
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear // Allows for customisability of cell
        self.configureClearSelectedBackground()
        
        self.containerView.addSubviews(self.exerciseNameLabel)
        self.contentView.addSubviews(self.containerView)
        
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: self.topAnchor),
            self.containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.containerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.985),
            self.containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.95),
            
            self.exerciseNameLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 50),
            self.exerciseNameLabel.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
        ])
    }
    
    // MARK: - Configurations
    public func configure(with viewModel: ReorderExercisesCellVM) {
        self.exerciseNameLabel.text = viewModel.workoutExercise.exercise?.name
        self.viewModel = viewModel
    }
}

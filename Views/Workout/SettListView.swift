//
//  SettList.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 10/17/23.
//

import UIKit

class SettListView: UIView {
    
    private var viewModel: SettListVM?
    
    // Table View for routines in each category
    public let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray3.withAlphaComponent(0.44)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SettListCell.self, forCellReuseIdentifier: SettListCell.cellIdentifier)
        tableView.isScrollEnabled = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return tableView
    }()
    
    // Container for workout exercise buttons
    public let workoutExercisesButtonsContainer: UIView = {
        let workoutExercisesButtonsContainer = UIView()
        workoutExercisesButtonsContainer.translatesAutoresizingMaskIntoConstraints = false
        workoutExercisesButtonsContainer.backgroundColor = .systemGray3.withAlphaComponent(0.44)
        workoutExercisesButtonsContainer.layer.cornerRadius = 15
        workoutExercisesButtonsContainer.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return workoutExercisesButtonsContainer
    }()
    
    // Add Sett Button
    private let addSettButton: UIButton = IconButton(imageName: "plus.square", color: .label, fontSize: 15.0, fontWeight: .light)
    
    // View Exercise Stats Button
    private let viewStatsButton: UIButton = IconButton(imageName: "chart.bar", color: .label, fontSize: 15.0, fontWeight: .light)
    
    // Reorder Setts Button
    private let reorderSettsButton: UIButton = IconButton(imageName: "line.3.horizontal", color: .label, fontSize: 15.0, fontWeight: .light)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.workoutExercisesButtonsContainer.addSubviews(self.addSettButton, self.viewStatsButton, self.reorderSettsButton)

        self.addSettButton.addTarget(self, action: #selector(addSett), for: .touchDown)
        
        self.addSubviews(self.tableView, self.workoutExercisesButtonsContainer)
        self.addConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.topAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.tableView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.88),
            
            self.workoutExercisesButtonsContainer.topAnchor.constraint(equalTo: self.tableView.bottomAnchor),
            self.workoutExercisesButtonsContainer.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.workoutExercisesButtonsContainer.rightAnchor.constraint(equalTo: self.rightAnchor),
          self.workoutExercisesButtonsContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.workoutExercisesButtonsContainer.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.12),
            
            self.addSettButton.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 3.375),
            self.addSettButton.centerYAnchor.constraint(equalTo: self.workoutExercisesButtonsContainer.centerYAnchor),
            
            self.viewStatsButton.leftAnchor.constraint(equalToSystemSpacingAfter: self.addSettButton.rightAnchor, multiplier: 3.25),
            self.viewStatsButton.centerYAnchor.constraint(equalTo: self.addSettButton.centerYAnchor),
            
            self.reorderSettsButton.leftAnchor.constraint(equalToSystemSpacingAfter: self.viewStatsButton.rightAnchor, multiplier: 3.25),
            self.reorderSettsButton.centerYAnchor.constraint(equalTo: self.addSettButton.centerYAnchor)
        ])

    }
    
    // MARK: - Configurations
    public func configure(with viewModel: SettListVM) {
        self.viewModel = viewModel
        self.workoutExercisesButtonsContainer.isHidden = !viewModel.isExpanded
        self.setUpTableView()
    }
    
    private func setUpTableView() {
        self.tableView.dataSource = self.viewModel
        self.tableView.delegate = self.viewModel
        self.viewModel?.tableView = self.tableView
    }
    
    // MARK: - Actions
    @objc func addSett() {
        self.viewModel?.addSett()
    }
}

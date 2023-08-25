//
//  ExerciseListView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/8/23.
//

import UIKit

class ExerciseListView: UIView {

    private var viewModel: ExerciseListViewModel?
    
    // Table View for workouts in each month
    public let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray3.withAlphaComponent(0.44)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ExerciseListCell.self, forCellReuseIdentifier: ExerciseListCell.cellIdentifier)
        tableView.isScrollEnabled = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none

        return tableView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(tableView)
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
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    // MARK: - Configurations
    public func configure(with viewModel: ExerciseListViewModel) {
        self.viewModel = viewModel
        self.viewModel!.exerciseListView = self
        setUpTableView()
    }
    
    private func setUpTableView() {
        self.tableView.dataSource = self.viewModel
        self.tableView.delegate = self.viewModel
    }

}

//
//  MonthWorkoutListView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/19/23.
//

import UIKit

final class MonthWorkoutListView: UIView {
    private var viewModel: MonthWorkoutListViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // Table View for workouts in each month
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray3.withAlphaComponent(0.44)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MonthWorkoutListCell.self, forCellReuseIdentifier: MonthWorkoutListCell.cellIdentifier)
        tableView.layer.cornerRadius = 15
        tableView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]

        return tableView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        addConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("Unsupported initializer")
    }
    
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Configurations
    public func configure(with viewModel: MonthWorkoutListViewModel) {
        self.viewModel = viewModel
        setUpTableView()
    }
    
    private func setUpTableView() {
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
    }
}

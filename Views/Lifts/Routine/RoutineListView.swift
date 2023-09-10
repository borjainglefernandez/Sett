//
//  RoutineListView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 9/10/23.
//

import UIKit

class RoutineListView: UIView {
    
    private var viewModel: RoutineListViewModel?
    
    // Table View for routines in each category
    public let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray3.withAlphaComponent(0.44)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RoutineListCell.self, forCellReuseIdentifier: RoutineListCell.cellIdentifier)
        tableView.isScrollEnabled = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.layer.cornerRadius = 15
        tableView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

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
    public func configure(with viewModel: RoutineListViewModel) {
        self.viewModel = viewModel
        self.setUpTableView()
    }
    
    private func setUpTableView() {
        self.tableView.dataSource = self.viewModel
        self.tableView.delegate = self.viewModel
    }
    
}

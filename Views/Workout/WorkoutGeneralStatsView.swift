//
//  WorkoutGeneralStatsView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/14/23.
//

import UIKit

final class WorkoutGeneralStatsView: UICollectionReusableView {
    
    private var viewModel: WorkoutGeneralStatsVM?
    
    // Top bar of the general stats view container
    private let topBar: UIView = {
        let topBar = UIView()
        topBar.translatesAutoresizingMaskIntoConstraints = false
        topBar.backgroundColor = .systemGray4
        topBar.layer.cornerRadius = 15
        topBar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return topBar
    }()
    
    // Table View for each category of general stats
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray3.withAlphaComponent(0.44)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(WorkoutGeneralStatsViewCell.self, forCellReuseIdentifier: WorkoutGeneralStatsViewCell.cellIdentifier)
        tableView.layer.cornerRadius = 15
        tableView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.autoresizingMask = .flexibleHeight
        return tableView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubviews(self.topBar, self.tableView)
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.topBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.topBar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.topBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.95),
            self.topBar.heightAnchor.constraint(equalToConstant: 30),
            
            self.tableView.topAnchor.constraint(equalTo: self.topBar.bottomAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.topBar.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.topBar.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setUpTableView() {
        self.tableView.dataSource = self.viewModel
        self.tableView.delegate = self.viewModel
        self.viewModel?.tableView = self.tableView
    }
    
    // MARK: - Configurations
    public func configure(viewModel: WorkoutGeneralStatsVM) {
        self.viewModel = viewModel
        self.setUpTableView()

    }
    
}

//
//  ModalTableView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/14/23.
//

import UIKit

class ModalTableView: UIView {
    
    private let viewModel: ModalTableViewModel
    
    // Top Bar
    private let topBar: MenuBar = {
        let topBar = MenuBar()
        topBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return topBar
    }()
    
    // Table View of the categories
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray3.withAlphaComponent(0.44)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ModalTableViewCell.self, forCellReuseIdentifier: ModalTableViewCell.cellIdentifier)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none

        return tableView
    }()
    
    // MARK: - Init
    init(frame: CGRect = .zero, viewModel: ModalTableViewModel) {
        self.viewModel = viewModel

        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        self.setUpTableView()
        self.addSubviews(self.topBar, self.tableView)
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.topBar.topAnchor.constraint(equalTo: self.topAnchor),
            self.topBar.heightAnchor.constraint(equalToConstant: 30),
            self.topBar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.topBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.95),
            
            self.tableView.topAnchor.constraint(equalTo: self.topBar.bottomAnchor),
            self.tableView.centerXAnchor.constraint(equalTo: self.topBar.centerXAnchor),
            self.tableView.widthAnchor.constraint(equalTo: self.topBar.widthAnchor),
            self.tableView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -30)
        ])
    }
    
    // MARK: - Configurations
    private func setUpTableView() {
        self.tableView.dataSource = self.viewModel
        self.tableView.delegate = self.viewModel
    }
}

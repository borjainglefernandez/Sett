//
//  ReorderExercisesView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 3/20/24.
//

import UIKit

class ReorderExercisesView: UIView {
    
    private var viewModel: ReorderExercisesVM
    
    // Table View for exercises in routine
    public let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ReorderExercisesCell.self, forCellReuseIdentifier: ReorderExercisesCell.cellIdentifier)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.isEditing = true
        tableView.allowsSelectionDuringEditing = true
        return tableView
    }()
    
   // MARK: - Init
    init(frame: CGRect = .zero, viewModel: ReorderExercisesVM) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        self.backgroundColor = .systemCyan
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.dataSource = self.viewModel
        self.tableView.delegate = self.viewModel
        self.viewModel.reorderExercisesView = self

        self.addSubviews(self.tableView)
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

}

//
//  SelectExerciseModal.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/31/23.
//

import UIKit

class SelectExerciseModal: UIView {
    
    private let viewModel: SelectExerciseModalVM
    
    // Search Bar for categories
    lazy var searchBar: UISearchBar = SearchBar(searchBarDelegate: self.exerciseListView.viewModel)
    
    // Category list
    lazy var exerciseListView: ModalTableView = {
        let categoryListVM = ModalTableVM(
            modalTableViewType: .exercise,
            modalTableViewSelectionType: .toggle,
            selectedCellCallBack: self.viewModel.selectCellCallback,
            shouldShowExerciseCallback: self.viewModel.shouldIncludeExercise(exercise:),
            category: self.viewModel.category)
        let exerciseListView = ModalTableView(viewModel: categoryListVM)
        return exerciseListView
    }()
    
    // MARK: - Init
    init(frame: CGRect = .zero, viewModel: SelectExerciseModalVM) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubviews(self.searchBar, self.exerciseListView)
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {

        NSLayoutConstraint.activate([
            self.searchBar.topAnchor.constraint(equalTo: self.topAnchor),
            self.searchBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.95),
            self.searchBar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.exerciseListView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 30),
            self.exerciseListView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.exerciseListView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.95),
            self.exerciseListView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30)
        ])
    }
}

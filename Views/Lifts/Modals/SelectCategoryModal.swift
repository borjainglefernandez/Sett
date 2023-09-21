//
//  SelectCategoryModal.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/29/23.
//

import UIKit

class SelectCategoryModal: UIView {
    
    private let viewModel: SelectCategoryModalVM
    
    // Search Bar for categories
    lazy var searchBar: UISearchBar = SearchBar(searchBarDelegate: self.categoryListView.viewModel)
    
    // Category list
    lazy var categoryListView: ModalTableView = {
        let categoryListVM = ModalTableVM(
            modalTableViewType: .category,
            modalTableViewSelectionType: .select,
            selectedCellCallBack: self.viewModel.selectCellCallback)
        let categoryListView = ModalTableView(viewModel: categoryListVM)
        return categoryListView
    }()
    
    // MARK: - Init
    init(frame: CGRect = .zero, viewModel: SelectCategoryModalVM) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubviews(self.searchBar, self.categoryListView)
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
            
            self.categoryListView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 30),
            self.categoryListView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.categoryListView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.95),
            self.categoryListView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30)
        ])
    }
}

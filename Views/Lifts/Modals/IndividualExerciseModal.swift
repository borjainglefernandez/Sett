//
//  InidividualExerciseModal.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/13/23.
//

import UIKit

class IndividualExerciseModal: UIView {
    
    private let viewModel: IndividualExerciseModalViewModel
    
    lazy var categoryListView: ModalTableView = {
        let categoryListViewModel = ModalTableViewModel(modalTableViewType: .category, modalTableViewSelectionType: .toggle, selectedCellCallBack: self.viewModel.selectCellCallback, category: self.viewModel.category)
        let categoryListView = ModalTableView(viewModel: categoryListViewModel)
        return categoryListView
    }()
    
    lazy var exerciseTypeListView: ModalTableView = {
        let exerciseTypeListViewModel = ModalTableViewModel(modalTableViewType: .exerciseType, modalTableViewSelectionType: .toggle, selectedCellCallBack: self.viewModel.selectCellCallback, exerciseType: self.viewModel.exercise?.type?.exerciseType)
        let exerciseTypeListView = ModalTableView(viewModel: exerciseTypeListViewModel)
        return exerciseTypeListView
    }()
    
    // MARK: - Init
    init(frame: CGRect = .zero, viewModel: IndividualExerciseModalViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubviews(self.categoryListView, self.exerciseTypeListView)
        self.addConstraints()
   }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.categoryListView.topAnchor.constraint(equalTo: self.topAnchor),
            self.categoryListView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.categoryListView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.95),
            self.categoryListView.heightAnchor.constraint(equalToConstant: 30 + 49 * 5),
            
            self.exerciseTypeListView.topAnchor.constraint(equalTo: self.categoryListView.bottomAnchor, constant: 30),
            self.exerciseTypeListView.centerXAnchor.constraint(equalTo: self.categoryListView.centerXAnchor),
            self.exerciseTypeListView.widthAnchor.constraint(equalTo: self.categoryListView.widthAnchor),
            self.exerciseTypeListView.heightAnchor.constraint(equalToConstant: 30 + 49 * 5),
        ])
    }
    
}

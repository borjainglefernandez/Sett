//
//  CategoryListCellCollectionViewCell.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/8/23.
//

import UIKit

class CategoryListCell: UICollectionViewCell {
    
    static let cellIdentifier = "CategoryListCell"
    
    // Top bar of the category list container
    public let collapsibleContainerTopBar: CollapsibleContainerTopBar = CollapsibleContainerTopBar()
    
    public let exerciseListView: ExerciseListView = ExerciseListView()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.layer.cornerRadius = 15

        self.addSubviews(collapsibleContainerTopBar, exerciseListView)
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported constructor")
    }
    
    // MARK: - LifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        self.collapsibleContainerTopBar.setTitleLabelText(title: "")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.collapsibleContainerTopBar.heightAnchor.constraint(equalToConstant: 30),
            self.collapsibleContainerTopBar.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.collapsibleContainerTopBar.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            self.exerciseListView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1, constant: -30),
            self.exerciseListView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.exerciseListView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.exerciseListView.leftAnchor.constraint(equalTo: self.leftAnchor)
        ])
    }
    
    // MARK: - Configurations
    public func configure(with viewModel: CategoryListCellViewModel, at indexPath: IndexPath, for collectionView: UICollectionView, isExpanded: Bool, delegate: CollapsibleContainerTopBarDelegate) {
        // Populate title label text
        let numExercises = viewModel.category.exercises?.count ?? 0
        let exerciseSuffix = numExercises == 1 ? "Exercise" : "Exercises"
        self.collapsibleContainerTopBar.setTitleLabelText(title: "\(viewModel.category.name!) - \(numExercises) \(exerciseSuffix)")
        
        // Configure view model of collapsible top bar
        let collapsibleContainerTopBarViewModel = CollapsibleContainerTopBarViewModel(collectionView: collectionView, isExpanded: isExpanded, indexPath: indexPath, delegate: delegate)
        self.collapsibleContainerTopBar.configure(with: collapsibleContainerTopBarViewModel)
        
        // Configure exercises list view
        self.exerciseListView.configure(with: ExerciseListViewModel(category: viewModel.category))
    }
}

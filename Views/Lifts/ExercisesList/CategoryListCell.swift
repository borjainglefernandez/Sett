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
    
    // List of all the exercises for a particular category
    public let exerciseListView: ExerciseListView = ExerciseListView()

    // Bottom bar
    lazy var addExerciseBottomBar: AddExerciseBottomBar = AddExerciseBottomBar()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.layer.cornerRadius = 15

        self.addSubviews(self.collapsibleContainerTopBar, self.exerciseListView)
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
    private func addConstraints(isExpanded: Bool) {
        NSLayoutConstraint.activate([
            self.collapsibleContainerTopBar.topAnchor.constraint(equalTo: self.topAnchor),
            self.collapsibleContainerTopBar.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.collapsibleContainerTopBar.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.collapsibleContainerTopBar.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            self.exerciseListView.topAnchor.constraint(equalTo: self.collapsibleContainerTopBar.bottomAnchor),
            self.exerciseListView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.exerciseListView.leftAnchor.constraint(equalTo: self.leftAnchor),
        ])
        
        if isExpanded {
            NSLayoutConstraint.activate([
                self.addExerciseBottomBar.leftAnchor.constraint(equalTo: self.leftAnchor),
                self.addExerciseBottomBar.rightAnchor.constraint(equalTo: self.rightAnchor),
                self.addExerciseBottomBar.topAnchor.constraint(equalTo: self.exerciseListView.bottomAnchor),
                self.addExerciseBottomBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                self.addExerciseBottomBar.heightAnchor.constraint(equalTo: self.collapsibleContainerTopBar.heightAnchor)
            ])
        }
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
        
        // Configure view model of add exercise bottom bar
        let addExerciseBottomBarViewModel = AddExerciseBottomBarViewModel(category: viewModel.category)
        self.addExerciseBottomBar.configure(with: addExerciseBottomBarViewModel)
        
        // Configure exercises list view
        self.exerciseListView.configure(with: ExerciseListViewModel(category: viewModel.category))
        
        if !isExpanded {
            self.addExerciseBottomBar.removeFromSuperview()
        } else {
            self.addSubview(self.addExerciseBottomBar)
        }
        self.addConstraints(isExpanded: isExpanded)
    }
}

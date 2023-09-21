//
//  CategoryListCellCollectionViewCell.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/8/23.
//

import UIKit

class CategoryListCell: UICollectionViewCell {
    
    static let cellIdentifier = "CategoryListCell"
    
    // Category
    private var category: Category?

    // Top bar of the category list container
    public let collapsibleContainerTopBar: CollapsibleContainerTopBar = CollapsibleContainerTopBar()
    
    // Category settings button
    private let categorySettingsIconButton: IconButton = IconButton(imageName: "ellipsis", color: .label)
    
    // List of all the exercises for a particular category
    public let exerciseListView: ExerciseListView = ExerciseListView()

    // Bottom bar
    lazy var addExerciseBottomBar: AddExerciseBottomBar = AddExerciseBottomBar(addExerciseCallBack: self.addExercise)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.layer.cornerRadius = 15
        
        self.setUpCategorySettingsButton()

        self.addSubviews(self.collapsibleContainerTopBar, self.categorySettingsIconButton, self.exerciseListView)
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
            
            self.categorySettingsIconButton.rightAnchor.constraint(
                equalTo: self.collapsibleContainerTopBar.expandCollapseButton.leftAnchor,
                constant: -10),
            self.categorySettingsIconButton.centerYAnchor.constraint(equalTo: self.collapsibleContainerTopBar.centerYAnchor),
            
            self.exerciseListView.topAnchor.constraint(equalTo: self.collapsibleContainerTopBar.bottomAnchor),
            self.exerciseListView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.exerciseListView.leftAnchor.constraint(equalTo: self.leftAnchor)
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
    public func configure(with viewModel: CategoryListCellViewModel,
                          at indexPath: IndexPath, for collectionView: UICollectionView,
                          isExpanded: Bool, delegate: CollapsibleContainerTopBarDelegate) {
        // Populate category object
        self.category = viewModel.category
        
        // Populate title label text
        let numExercises = viewModel.category.exercises?.count ?? 0
        let exerciseSuffix = numExercises == 1 ? "Exercise" : "Exercises"
        self.collapsibleContainerTopBar.setTitleLabelText(title: "\(viewModel.category.name!) - \(numExercises) \(exerciseSuffix)")
        
        // Configure view model of collapsible top bar
        let collapsibleContainerTopBarViewModel = CollapsibleContainerTopBarViewModel(
            collectionView: collectionView,
            isExpanded: isExpanded,
            indexPath: indexPath,
            delegate: delegate)
        self.collapsibleContainerTopBar.configure(with: collapsibleContainerTopBarViewModel)
        
        // Configure exercises list view
        self.exerciseListView.configure(with: ExerciseListViewModel(category: viewModel.category))
        
        if !isExpanded {
            self.addExerciseBottomBar.removeFromSuperview()
        } else {
            self.addSubview(self.addExerciseBottomBar)
        }
        self.addConstraints(isExpanded: isExpanded)
    }
    
    private func setUpCategorySettingsButton() {
        self.categorySettingsIconButton.showsMenuAsPrimaryAction = true
        
        let changeCategoryNameAction = UIAction(title: "Edit name", attributes: [], state: .off) { _ in
            let addCategoryViewModel = AddCategoryViewModel(category: self.category)
            if let parentViewController = self.getParentViewController(self) {
                parentViewController.present(addCategoryViewModel.alertController, animated: true)
            }
            
        }
        
        let deleteCategoryAction = UIAction(title: "Delete",
                                            attributes: [.destructive], state: .off) { _ in
            if let category = self.category {
                // Controller
                let deleteCategoryViewController = UIAlertController(
                    title: "Delete \(String(describing: category.name!))?",
                    message: "This action cannot be undone.",
                    preferredStyle: .actionSheet)
                
                // Actions
                deleteCategoryViewController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                    CoreDataBase.context.delete(category)
                    CoreDataBase.save()
                    
                }))
                deleteCategoryViewController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                
                if let parentViewController = self.getParentViewController(self) {
                    parentViewController.present(deleteCategoryViewController, animated: true)
                }
            }
            
        }
        
        self.categorySettingsIconButton.menu = UIMenu(preferredElementSize: .small, children: [changeCategoryNameAction, deleteCategoryAction])
    }
    
    // MARK: - Actions
    public func addExercise() {
        if let parentVC = self.getParentViewController(self) as? LiftsViewController {
            if let category = self.category {
                parentVC.addExercise(category: category)
            }
            
        }
    }
}

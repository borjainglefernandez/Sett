//
//  ExercisesViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/8/23.
//

import Foundation
import CoreData
import UIKit

final class ExercisesViewModel: NSObject {

    public var exercisesView: ExercisesView?
    private var cellViewModels: [CategoryListCellViewModel] = []
    private var isExpanded: [Bool] = []
    private var fetchedResultsController: NSFetchedResultsController<Category> = {
        return CoreDataBase.createFetchedResultsController(withEntityName: "Category",
                                                           expecting: Category.self,
                                                           sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
    }()

    // MARK: - Configurations

    /// Configure all the necessary variables
    public func configure() {
        CoreDataBase.configureFetchedResults(controller: self.fetchedResultsController, expecting: Category.self, with: self)

        // Reset variables in case of update
        self.cellViewModels = []
        self.isExpanded = []

        guard let categories = self.fetchedResultsController.fetchedObjects else {
            return
        }

        for category in categories {
            let viewModel = CategoryListCellViewModel(category: category)
            self.cellViewModels.append(viewModel)
            self.isExpanded.append(true)
        }
    }

    // MARK: - Actions
    public func getCategoriesLength() -> Int {
        if let categoriesLength = self.fetchedResultsController.fetchedObjects?.count {
            return categoriesLength
        }
        return 0
    }
}

// MARK: - Collection View Delegate
extension ExercisesViewModel: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getCategoriesLength()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryListCell.cellIdentifier,
            for: indexPath
        ) as? CategoryListCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row],
                       at: indexPath, for: collectionView,
                       isExpanded: self.isExpanded[indexPath.row],
                       delegate: self)
        cell.collapsibleContainerTopBar.changeButtonIcon() // Expand or collapse container

        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isExpanded[indexPath.row] {
            let exerciseCount = self.cellViewModels[indexPath.row].category.exercises?.count ?? 0
            return CGSize(width: (collectionView.safeAreaLayoutGuide.layoutFrame.width - 20), height: CGFloat(exerciseCount * 43) + 62)
        }
        return CGSize(width: (collectionView.safeAreaLayoutGuide.layoutFrame.width - 20), height: 30)
    }
}

// MARK: - Expanded Cell Delegate
extension ExercisesViewModel: CollapsibleContainerTopBarDelegate {
    /// Collapse or Expand selected Month Workout Container
    ///
    /// - Parameters:
    ///   - indexPath: The index of the month workout container to expand or collapse
    ///   - collectionView: The collection view of the month workout container
    func collapseExpand(indexPath: IndexPath, collectionView: UICollectionView) {
        self.isExpanded[indexPath.row] = !self.isExpanded[indexPath.row]
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.8,
                           delay: 0.0, usingSpringWithDamping: 0.9,
                           initialSpringVelocity: 0.9,
                           options: UIView.AnimationOptions.curveEaseInOut, animations: {
                collectionView.reloadItems(at: [indexPath])
            })
        }
    }
}

// MARK: - Fetched Results Controller Delegate
extension ExercisesViewModel: NSFetchedResultsControllerDelegate {
    // Update screen if CRUD conducted on Categories
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        self.configure()
        self.exercisesView?.collectionView.reloadData()
        self.exercisesView?.showHideCollectionView()
    }
}

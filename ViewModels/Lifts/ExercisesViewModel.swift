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
        return CoreDataBase.createFetchedResultsController(withEntityName: "Category", expecting: Category.self)
    }()
    
    // MARK: - Configurations
    
    /// Configure all the necessary variables
    public func configure() {
        CoreDataBase.configureFetchedResults(controller: self.fetchedResultsController, expecting: Category.self, with: self)
        
        // Reset variables in case of update
        self.cellViewModels = []
        
        guard let categories = self.fetchedResultsController.fetchedObjects else {
            return
        }
        
        for category in categories {
            let viewModel = CategoryListCellViewModel(categoryName: category.name!, numExercises: category.exercises?.count ?? 0)
            self.cellViewModels.append(viewModel)
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
        cell.configure(with: cellViewModels[indexPath.row])
        cell.showHideMonthListView(isExpanded: self.isExpanded[indexPath.row]) // Expand or collapse container
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isExpanded[indexPath.row] {
            
            return CGSize(width: (collectionView.safeAreaLayoutGuide.layoutFrame.width - 20), height: CGFloat(self.cellViewModels[indexPath.row].numExercises * 43) + 31)
        }
        return CGSize(width: (collectionView.safeAreaLayoutGuide.layoutFrame.width - 20), height: 30)
    }
}

// MARK: - Fetched Results Controller Delegate
extension ExercisesViewModel: NSFetchedResultsControllerDelegate {
    // Update screen if CRUD conducted on Workouts
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        self.configure()
        self.exercisesView?.collectionView.reloadData()
        self.exercisesView?.showHideCollectionView()
    }
}



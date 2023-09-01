//
//  RoutineExerciseListViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/28/23.
//

import Foundation
import CoreData
import UIKit

final class RoutineExerciseListViewModel: NSObject {
    public let routine: Routine
    private var cellViewModels: [RoutineExerciseListCellViewModel] = []
    lazy var fetchedResultsController: NSFetchedResultsController<Routine> = {
        return CoreDataBase.createFetchedResultsController(withEntityName: "Routine", expecting: Routine.self, predicates: [NSPredicate(format: "uuid = %@", argumentArray: [self.routine.uuid])])
    }()
    public var routineExerciseList: RoutineExerciseList?
    
    // MARK: - Init
    init(routine: Routine) {
        self.routine = routine
    }
    
    // MARK: - Configurations
    
    /// Configure all the necessary variables
    public func configure() {
        CoreDataBase.configureFetchedResults(controller: self.fetchedResultsController, expecting: Routine.self, with: self)
        
        // Reset variables in case of update
        self.cellViewModels = []
        
        guard let exercises = self.fetchedResultsController.fetchedObjects?.first?.exercises else {
            return
        }
        
        for exercise in exercises {
            let viewModel = RoutineExerciseListCellViewModel(exercise: exercise as! Exercise)
            self.cellViewModels.append(viewModel)
        }
    }
}


// MARK: - Collection View Delegate
extension RoutineExerciseListViewModel: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RoutineExerciseListCell.cellIdentifier,
            for: indexPath
        ) as? RoutineExerciseListCell else {
            fatalError("Unsupported cell")
        }
        
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.safeAreaLayoutGuide.layoutFrame.width - 20), height: 100)
    }
}

extension RoutineExerciseListViewModel: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        self.configure()
        self.routineExerciseList?.collectionView.reloadData()
    }
    
}

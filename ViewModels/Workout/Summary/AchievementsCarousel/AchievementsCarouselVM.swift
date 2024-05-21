//
//  AchievementsCarouselVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/24/24.
//

import Foundation
import CoreData
import UIKit

final class AchievementsCarouselVM: NSObject {
    
    public var workout: Workout
    public var achievementsCarouselView: AchievementsCarouselView?
    private var cellVMs: [AchievementsCarouselCellVM] = []
    lazy var fetchedResultsController: NSFetchedResultsController<Achievement> = {
        return CoreDataBase.createFetchedResultsController(
                    withEntityName: "Achievement",
                    expecting: Achievement.self,
                    predicates: [NSPredicate(format: "workout = %@", self.workout.objectID)])
    }()
    
    // MARK: - Init
    init(workout: Workout) {
        self.workout = workout
        super.init()
    }
    
    // MARK: - Configurations
    public func configure() {
        // New information, overwrite
        self.cellVMs = []
        
        // Listen for updates to specific workout
        CoreDataBase.configureFetchedResults(controller: self.fetchedResultsController, expecting: Achievement.self, with: self)
        guard let achievements = self.fetchedResultsController.fetchedObjects else {
            return
        }
        
        // Add relevant cell vms
        for achievement in achievements {
            let viewModel = AchievementsCarouselCellVM(achievement: achievement)
            self.cellVMs.append(viewModel)
        }
    }
    
    // MARK: - Actions
    public func getAchievementsLength() -> Int {
        return self.cellVMs.count
    }
}

// MARK: - Collection View Delegate
extension AchievementsCarouselVM: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.getAchievementsLength()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AchievementsCarouselCell.cellIdentifier,
            for: indexPath
        ) as? AchievementsCarouselCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: cellVMs[indexPath.row])

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
        
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0 // No spacing between items
    }
    
}

// MARK: - UICollection View Delegate
extension AchievementsCarouselVM: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let currentPage = Int(scrollView.contentOffset.x / pageWidth)
        if let workoutSummaryViewController =
            scrollView.getParentViewController(scrollView) as? WorkoutSummaryViewController {
            workoutSummaryViewController.changePagination(currentPage: currentPage)
        }
    }
}

// MARK: - Fetched Results Controller Delegate
extension AchievementsCarouselVM: NSFetchedResultsControllerDelegate {
    
    // Update screen if CRUD conducted on Workout
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        DispatchQueue.main.async {
            self.configure()
            self.achievementsCarouselView?.collectionView.reloadData()
        }
    }
    
}

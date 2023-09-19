//
//  RoutinesViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/8/23.
//

import Foundation
import CoreData
import UIKit

final class RoutinesViewModel: NSObject {
    
    public var routinesView: RoutinesView?
    private var cellViewModels: [RoutineDayOfTheWeekCellVM] = []
    private var isExpanded: [Bool] = []
    private var fetchedResultsController: NSFetchedResultsController<Routine> = {
        return CoreDataBase.createFetchedResultsController(
                withEntityName: "Routine",
                expecting: Routine.self,
                sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
    }()
    
    // MARK: - Configurations
    
    /// Configure all the necessary variables
    public func configure() {
        
        CoreDataBase.configureFetchedResults(controller: self.fetchedResultsController, expecting: Routine.self, with: self)
    
        self.cellViewModels = []
        self.isExpanded = []
        
        guard let routines: [Routine] = self.fetchedResultsController.fetchedObjects else {
            return
        }
        
//        for routine in routines {
//            print(routine)
//        }
//        print(routines.count)
        
        // Create all the days of the week
        for dayOfTheWeek in DayOfTheWeek.allCases {
            let routinesPerformedOnDayOfTheWeek: [Routine] = routines.filter { routine in
                return routine.daysOfTheWeek?.contains { dayOfTheWeekWrapper in
                    return dayOfTheWeekWrapper.dayOfTheWeek == dayOfTheWeek
                } ??  false
            }
            
            if !routinesPerformedOnDayOfTheWeek.isEmpty {
                let viewModel = RoutineDayOfTheWeekCellVM(dayOfTheWeek: dayOfTheWeek, routines: routinesPerformedOnDayOfTheWeek)
                self.cellViewModels.append(viewModel)
                self.isExpanded.append(true)
            }
        }
        
        // Get current day of the week
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" // "EEEE" gives the full day name (e.g., "Monday")
        let dayOfWeekString = dateFormatter.string(from: currentDate)
        
        // Start from current day of the week
        let currentDayOfTheWeekIndex: Int = self.cellViewModels.firstIndex(where: {$0.dayOfTheWeek?.rawValue == dayOfWeekString}) ?? 0
        self.cellViewModels = Array(self.cellViewModels[currentDayOfTheWeekIndex...] + self.cellViewModels[0..<currentDayOfTheWeekIndex])
    
        // Add unspecified category if needed
        let routinesWithoutDayOfTheWeek: [Routine] = routines.filter { routine in
            return routine.daysOfTheWeek == nil || (routine.daysOfTheWeek?.isEmpty ?? true)
        }
        if !routinesWithoutDayOfTheWeek.isEmpty {
            self.cellViewModels.append(RoutineDayOfTheWeekCellVM(routines: routinesWithoutDayOfTheWeek))
            self.isExpanded.append(true)
        }
    }
    
    // MARK: - Actions 
    public func getRoutineCategoryLength() -> Int {
        return self.cellViewModels.count
    }
}


// MARK: - Collection View Delegate
extension RoutinesViewModel: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.getRoutineCategoryLength()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RoutineDayOfTheWeekCell.cellIdentifier,
            for: indexPath
        ) as? RoutineDayOfTheWeekCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row], at: indexPath, for: collectionView, isExpanded: self.isExpanded[indexPath.row], delegate: self)
        cell.collapsibleContainerTopBar.changeButtonIcon() // Expand or collapse container

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isExpanded[indexPath.row] {
            let exerciseCount = self.cellViewModels[indexPath.row].routines.count
            return CGSize(width: (collectionView.safeAreaLayoutGuide.layoutFrame.width - 20), height: CGFloat(exerciseCount * 43) + 31)
        }
        return CGSize(width: (collectionView.safeAreaLayoutGuide.layoutFrame.width - 20), height: 30)
    }
}

// MARK: - Expanded Cell Delegate
extension RoutinesViewModel: CollapsibleContainerTopBarDelegate {
    /// Collapse or Expand selected Month Workout Container
    ///
    /// - Parameters:
    ///   - indexPath: The index of the month workout container to expand or collapse
    ///   - collectionView: The collection view of the month workout container
    func collapseExpand(indexPath: IndexPath, collectionView: UICollectionView) {
        self.isExpanded[indexPath.row] = !self.isExpanded[indexPath.row]
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9,
                options: UIView.AnimationOptions.curveEaseInOut, animations: {
                collectionView.reloadItems(at: [indexPath])
            })
        }
    }
}

// MARK: - Fetched Results Controller Delegate
extension RoutinesViewModel: NSFetchedResultsControllerDelegate {
    // Update screen if CRUD conducted on Categories
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        DispatchQueue.main.async {
            self.configure()
            self.routinesView?.collectionView.reloadData()
            self.routinesView?.showHideCollectionView()
        }
    }
}



//
//  WorkoutListViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/16/23.
//

import UIKit
import CoreData

final class HomeViewModel: NSObject {
    
    public var homeView: HomeView?
    private var cellViewModels: [MonthListCellViewModel] = []
    private var isExpanded: [Bool] = []
    private var workoutsByMonth: [String: [Workout]] = [String: [Workout]]()
    private var fetchedResultsController: NSFetchedResultsController<Workout> = {
        return CoreDataBase.creatFetchedResultsController(withEntityName: "Workout", expecting: Workout.self, sortDescriptors: [NSSortDescriptor(key: "startTime", ascending: true)])
    }()
    
    // MARK: - Configurations
    
    /// Puts each workout in the corresponding month and year
    private func setMonthYearWorkoutsDict(_ workoutsToAdd: [Workout]) -> Void {
        for workout in workoutsToAdd {
            guard let startTime = workout.startTime else { // Don't add if no startTime found
                continue
            }
            let month = Calendar.current.component(.month, from: startTime)
            let year = Calendar.current.component(.year, from: startTime)
            
            // Add month and year if it does not exist
            if !self.workoutsByMonth.keys.contains("\(month)/\(year)") {
                self.workoutsByMonth["\(month)/\(year)"] = []
            }
            
            self.workoutsByMonth["\(month)/\(year)"]?.append(workout)
        }
    }
    
    /// Initialize the cell view models from the workouts
    private func initCellViewModels() {
        
        let sortedKeys = self.workoutsByMonth.keys.sorted(using: .localizedStandard).reversed() // Reverse chronological order
        for monthYear in sortedKeys {
            let viewModel = MonthListCellViewModel(monthName: monthYear, numWorkouts: workoutsByMonth[monthYear]?.count ?? 0)
            self.cellViewModels.append(viewModel)
            self.isExpanded.append(true)
            
        }
    }
    
    /// Configure all the necessary variables
    public func configure() {
        CoreDataBase.configureFetchedResults(controller: self.fetchedResultsController, expecting: Workout.self, with: self)
        
        // Reset variables in case of update
        self.cellViewModels = []
        self.workoutsByMonth = [String: [Workout]]()
        
        // Get workouts in order of start time
        guard let workoutsByStartTime = self.fetchedResultsController.fetchedObjects else {
            return
        }
        self.setMonthYearWorkoutsDict(workoutsByStartTime)
        self.initCellViewModels()
    }
    
    // TODO: GET RID OF THIS
    private func getRandomDate() -> Date {
        
        var randomDate = DateComponents()
        randomDate.month = Int.random(in: 1...12)
        randomDate.day = Int.random(in: 1...27)
        randomDate.year = 2023
        if let date = Calendar.current.date(from: randomDate)
        {
            return date
        }
        return Date()
    }
    
    // MARK: - Actions
    public func addWorkout() {
        let randomTitleList = ["Push 1", "Push 2", "Pull 1", "Pull 2", "Leg 1", "Leg 2"]
        
        let newWorkout = Workout(context: CoreDataBase.context)
        
        newWorkout.rating = Double.random(in: 0...5)
        newWorkout.startTime = getRandomDate()
        newWorkout.title = randomTitleList.randomElement()
        CoreDataBase.save()
        
        DispatchQueue.main.async {
            self.configure()
        }
    }
    
    public func getWorkoutsLength() -> Int {
        if let workoutsLength = self.fetchedResultsController.fetchedObjects?.count {
            return workoutsLength
        }
        return 0
    }
}

// MARK: - Collection View Delegate
extension HomeViewModel: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.workoutsByMonth.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MonthListCell.cellIdentifier,
            for: indexPath
        ) as? MonthListCell else {
            fatalError("Unsupported cell")
        }
        
        cell.indexPath = indexPath
        cell.delegate = self
        cell.configure(with: cellViewModels[indexPath.row])
        cell.showHideMonthListView(isExpanded: self.isExpanded[indexPath.row]) // Expand or collapse container
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isExpanded[indexPath.row] {
            
            return CGSize(width: (collectionView.safeAreaLayoutGuide.layoutFrame.width - 20), height: CGFloat(self.cellViewModels[indexPath.row].numWorkouts * 43) + 31)
        }
        return CGSize(width: (collectionView.safeAreaLayoutGuide.layoutFrame.width - 20), height: 30)
    }
}

// MARK: - Fetched Results Controller Delegate
extension HomeViewModel: NSFetchedResultsControllerDelegate {
    // Update screen if CRUD conducted on Workouts
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        self.configure()
        self.homeView?.collectionView.reloadData()
    }
}

// MARK: - Expanded Cell Delegate
extension HomeViewModel:ExpandedCellDelegate{
    /// Collapse or Expand selected Month Workout Container
    ///
    /// - Parameters:
    ///   - indexPath: The index of the month workout container to expand or collapse
    ///   - collectionView: The collection view of the month workout container
    func collapseExpand(indexPath: IndexPath, collectionView: UICollectionView) {
        self.isExpanded[indexPath.row] = !self.isExpanded[indexPath.row]
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                collectionView.reloadItems(at: [indexPath])
            })
        }
    }
}

// MARK: - Workouts Delegate
extension HomeViewModel:WorkoutsDelegate {
    func addWorkout(collectionView: UICollectionView) {
        self.addWorkout()
    }
}

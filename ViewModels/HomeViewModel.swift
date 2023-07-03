//
//  WorkoutListViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/16/23.
//

import UIKit
import CoreData

final class HomeViewModel: NSObject {
    
    private var cellViewModels: [MonthListCellViewModel] = []
    private var isExpanded: [Bool] = []
    private var workoutsByMonth: [String: [Workout]] = [String: [Workout]]()
    
    // MARK: - Configurations
    
    /// Creates a dictionary with the month and year as a key and an empty list as the value
    private func initMonthYearWorkoutDict(_ workoutsByMonthYear: [NSDictionary]) -> Void {
        for monthYear in workoutsByMonthYear {
            if let monthYearDate = monthYear["startTime"] as? Date {
                let month = Calendar.current.component(.month, from: monthYearDate)
                let year = Calendar.current.component(.year, from: monthYearDate)
                self.workoutsByMonth["\(month)/\(year)"] = []
            }
        }
    }
    
    /// Puts each workout in the corresponding month and year
    private func setMonthYearWorkoutsDict(_ workoutsToAdd: [Workout]) -> Void {
        for workout in workoutsToAdd {
            guard let startTime = workout.startTime else { // Don't add if no startTime found
                continue
            }
            let month = Calendar.current.component(.month, from: startTime)
            let year = Calendar.current.component(.year, from: startTime)
            self.workoutsByMonth["\(month)/\(year)"]?.append(workout)
        }
    }
    
    /// Initialize the cell view models from the workouts
    private func initCellViewModels() {
        let sortedKeys = self.workoutsByMonth.keys.sorted().reversed() // Reverse chronological order
        for monthYear in sortedKeys {
            let viewModel = MonthListCellViewModel(monthName: monthYear, numWorkouts: workoutsByMonth[monthYear]?.count ?? 0)
            self.cellViewModels.append(viewModel)
            self.isExpanded.append(true)
            
        }
    }
    
    /// Configure all the necessary variables
    public func configure() {
        // Get workouts Grouped by the Month and Year
        guard let workoutsByMonthYear = CoreDataBase.fetchEntities(withEntity: "Workout", expecting: NSDictionary.self, sortDescriptors: [NSSortDescriptor(key: "monthYear", ascending: true)], propertiesToGroupBy: ["monthYear"]) else {
            return
        }
        self.initMonthYearWorkoutDict(workoutsByMonthYear)
        
        // Get all workouts
        guard let workouts = CoreDataBase.fetchEntities(withEntity: "Workout", expecting: Workout.self) else {
            return
        }
        self.setMonthYearWorkoutsDict(workouts)
        self.initCellViewModels()
    }
    
    // MARK: - Actions
    public func addWorkout() {
        let newWorkout = Workout(context: CoreDataBase.context)
        newWorkout.rating = 3
        newWorkout.duration = 35
        
        let todayComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let today = Calendar.current.date(from: todayComponents)
        newWorkout.startTime = today
        newWorkout.title = "Push 1"
        CoreDataBase.save()
    }
    
}

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
        
        cell.delegate = self
        cell.configure(with: cellViewModels[indexPath.row])
        cell.showHideMonthListView(isExpanded: self.isExpanded[indexPath.row]) // Expand or collapse container
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isExpanded[indexPath.row] {
            return CGSize(width: (collectionView.safeAreaLayoutGuide.layoutFrame.width - 20), height: 320)
        }
        return CGSize(width: (collectionView.safeAreaLayoutGuide.layoutFrame.width - 20), height: 30)
    }
    
    
    
}

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

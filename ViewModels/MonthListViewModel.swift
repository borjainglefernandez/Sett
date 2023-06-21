//
//  WorkoutListViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/16/23.
//

import UIKit
import CoreData

final class MonthListViewModel: NSObject {
    
    private var cellViewModels: [MonthWorkoutListCellViewModel] = []
    private var workoutsByMonth: [String: [Workout]] = [String: [Workout]]()
    
    
    public func configure() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var monthYearWorkoutDict = [String: [Workout]]()
        let calendar = Calendar.current
        
        do {
            let monthYearFetchRequest = NSFetchRequest<NSDictionary>(entityName: "Workout")
            monthYearFetchRequest.resultType = .dictionaryResultType
            monthYearFetchRequest.propertiesToFetch = ["monthYear"]
            monthYearFetchRequest.propertiesToGroupBy = ["monthYear"]
            
            let monthYears = try context.fetch(monthYearFetchRequest)
            
            for monthYear in monthYears {
                if let monthYearDate = monthYear["monthYear"] as? Date {
                    let month = calendar.component(.month, from: monthYearDate)
                    let year = calendar.component(.year, from: monthYearDate)
                    monthYearWorkoutDict["\(month)/\(year)"] = []
                }
            }
            
            
            let workoutsFetchRequest = Workout.fetchRequest()
            let workouts = try context.fetch(workoutsFetchRequest)
            
            
            for workout in workouts {
                guard let startTime = workout.startTime else {
                    continue
                }
                let month = calendar.component(.month, from: startTime)
                let year = calendar.component(.year, from: startTime)
                monthYearWorkoutDict["\(month)/\(year)"]?.append(workout)
            }
            
            for monthYear in monthYearWorkoutDict.keys {
                let viewModel = MonthWorkoutListCellViewModel(monthName: monthYear, numWorkouts: monthYearWorkoutDict[monthYear]?.count ?? 0)
                
                self.cellViewModels.append(viewModel)
                
            }
            
        } catch {
            print("Something went wrong!")
        }
        self.workoutsByMonth = monthYearWorkoutDict
    }
    
}

extension MonthListViewModel: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.workoutsByMonth.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MonthWorkoutListCell.cellIdentifier,
            for: indexPath
        ) as? MonthWorkoutListCell else {
            fatalError("Unsupported cell")
        }
        
        cell.configure(with: cellViewModels[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.safeAreaLayoutGuide.layoutFrame.width - 20), height: 320)
    }
}

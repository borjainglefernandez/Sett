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
    
    
    public func configure() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var monthYearWorkoutDict = [String: [Workout]]()
        let calendar = Calendar.current
        
        do {
            let monthYearFetchRequest = NSFetchRequest<NSDictionary>(entityName: "Workout")
            monthYearFetchRequest.resultType = .dictionaryResultType
            monthYearFetchRequest.propertiesToFetch = ["monthYear"]
            monthYearFetchRequest.propertiesToGroupBy = ["monthYear"]
            let sortDescriptor = NSSortDescriptor(key: "monthYear", ascending: true)
            monthYearFetchRequest.sortDescriptors = [sortDescriptor]
            
            
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
            
            let sortedKeys = monthYearWorkoutDict.keys.sorted().reversed()
            for monthYear in sortedKeys {
                let viewModel = MonthListCellViewModel(monthName: monthYear, numWorkouts: monthYearWorkoutDict[monthYear]?.count ?? 0)
                
                self.cellViewModels.append(viewModel)
                self.isExpanded.append(true)
                
            }
            
        } catch {
            print("Something went wrong!")
        }
        self.workoutsByMonth = monthYearWorkoutDict
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
        cell.indexPath = indexPath
        cell.delegate = self
        cell.configure(with: cellViewModels[indexPath.row])
        cell.showHideMonthListView(isExpanded: self.isExpanded[indexPath.row])
        
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
    func collapseExpand(indexPath: IndexPath, collectionView: UICollectionView) {
        self.isExpanded[indexPath.row] = !self.isExpanded[indexPath.row]
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                collectionView.reloadItems(at: [indexPath])
            })
        }
    }
}

//
//  MonthWorkoutListViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/19/23.
//

import UIKit
import CoreData

final class MonthWorkoutListViewModel: NSObject {
    public var month: Int
    public var year: Int
    public var workouts: [Workout] = []
    private var cellViewModels: [MonthWorkoutListCellViewModel] = []
    
    // MARK: - Init
    
    init(
        month: Int,
        year: Int
    ) {
        self.month = month
        self.year = year
        super.init()
        self.setWorkouts()
    }
    
    // MARK: - Actions
    
    /// Fetch and set the workouts for the month
    public func setWorkouts() {
        // Create start and end dates for a particular month
        let startDateComponents = DateComponents(year: self.year, month: self.month, day: 1, hour: 0, minute: 0, second: 0)
        var incrementDateComponents = DateComponents()
        incrementDateComponents.month = 1
        let calendar:Calendar = Calendar.current
        guard let startDate: Date = calendar.date(from: startDateComponents),
              let endDate: Date = calendar.date(byAdding: incrementDateComponents, to: startDate) else {
                  fatalError("Dates could not be converted")
              }
        
        // Get workouts for particular month
        let predicate = NSPredicate(format: "(startTime >= %@) AND (startTime < %@)", startDate as NSDate, endDate as NSDate)
        
        if let workouts  = CoreDataBase.fetchEntities(withEntity: "Workout", expecting: Workout.self, predicates: [predicate]) {
            self.workouts = workouts
            for workout in self.workouts {
                let viewModel = MonthWorkoutListCellViewModel(workout: workout)
                self.cellViewModels.append(viewModel)
            }
        }
        
    }
    
}

extension MonthWorkoutListViewModel: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MonthWorkoutListCell.cellIdentifier,
            for: indexPath
        ) as? MonthWorkoutListCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: self.cellViewModels[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.workouts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43
    }
}

//
//  MonthWorkoutListViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/19/23.
//

import UIKit
import CoreData

final class MonthWorkoutListViewModel:NSObject {
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
    
    public func setWorkouts() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let startDateComponents = DateComponents(year: self.year, month: self.month, day: 1, hour: 0, minute: 0, second: 0)
        
        var incrementDateComponents = DateComponents()
        incrementDateComponents.month = 1
        
        
        let fetchRequest: NSFetchRequest<Workout> = Workout.fetchRequest()
        let calendar = Calendar.current
        
        if let startDate = calendar.date(from: startDateComponents),
           let endDate = calendar.date(byAdding: incrementDateComponents, to: startDate) {
            let predicate = NSPredicate(format: "(startTime >= %@) AND (startTime < %@)", startDate as NSDate, endDate as NSDate)
            fetchRequest.predicate = predicate
            
            do {
                self.workouts = try context.fetch(fetchRequest)
                for workout in self.workouts {
                    let viewModel = MonthWorkoutListCellViewModel(workout: workout)
                    self.cellViewModels.append(viewModel)
                }
            } catch {
                // Handle fetch error
                fatalError("Error fetching workouts: \(error)")
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
        cell.clipsToBounds = true

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

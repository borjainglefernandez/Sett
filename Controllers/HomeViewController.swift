//
//  HomeViewController.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/7/23.
//

import UIKit
import CoreData

final class HomeViewController: UIViewController {
    
    private let monthListView = MonthListView()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        configureMonthWorkouts()
        calculateMonths()
        view.addSubview(monthListView)
        NSLayoutConstraint.activate([
            monthListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            monthListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            monthListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            monthListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureMonthWorkouts() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let workout1 = Workout(context: self.context)
        workout1.startTime = dateFormatter.date(from: "2023-06-21 15:30:00")
        workout1.rating = 5
        let calendar = Calendar.current
        var components = DateComponents(year: 2023, month: 5)
        workout1.monthYear = calendar.date(from: components)
        
        let workout2 = Workout(context: self.context)
        workout2.startTime = dateFormatter.date(from: "2023-07-21 15:30:00")
        workout2.rating = 3
        components = DateComponents(year: 2023, month: 7)
        workout2.monthYear = calendar.date(from: components)
        
        
        
        do {
            try self.context.save()
        } catch {
            print("here")
        }
        
    }
    
    private func calculateMonths() -> [String: [Workout]] {
        var monthYearWorkoutDict = [String: [Workout]]()
        let calendar = Calendar.current
        
        
        do {
            let monthYearFetchRequest = NSFetchRequest<NSDictionary>(entityName: "Workout")
            monthYearFetchRequest.resultType = .dictionaryResultType
            monthYearFetchRequest.propertiesToFetch = ["monthYear"]
            monthYearFetchRequest.propertiesToGroupBy = ["monthYear"]
            
            let monthYears = try self.context.fetch(monthYearFetchRequest)
            
            for monthYear in monthYears {
                if let monthYearDate = monthYear["monthYear"] as? Date {
                    let month = calendar.component(.month, from: monthYearDate)
                    let year = calendar.component(.year, from: monthYearDate)
                    monthYearWorkoutDict["\(month)/\(year)"] = []
                }
            }
            
            
            let workoutsFetchRequest = Workout.fetchRequest()
            let workouts = try self.context.fetch(workoutsFetchRequest)
            
            
            for workout in workouts {
                guard let startTime = workout.startTime else {
                    continue
                }
                let month = calendar.component(.month, from: startTime)
                let year = calendar.component(.year, from: startTime)
                monthYearWorkoutDict["\(month)/\(year)"]?.append(workout)
            }
            
        } catch {
            print("Something went wrong!")
        }
        return monthYearWorkoutDict
    }
    
}


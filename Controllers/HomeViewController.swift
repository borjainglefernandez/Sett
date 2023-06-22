//
//  HomeViewController.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/7/23.
//

import UIKit
import CoreData

final class HomeViewController: UIViewController {
    
    private let homeView = HomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        view.addSubview(homeView)
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homeView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            homeView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
//    private func configureMonthWorkouts() {
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//
//        let workout1 = Workout(context: self.context)
//        workout1.startTime = dateFormatter.date(from: "2023-06-21 15:30:00")
//        workout1.rating = 5
//        let calendar = Calendar.current
//        var components = DateComponents(year: 2023, month: 5)
//        workout1.monthYear = calendar.date(from: components)
//
//        let workout2 = Workout(context: self.context)
//        workout2.startTime = dateFormatter.date(from: "2023-07-21 15:30:00")
//        workout2.rating = 3
//        components = DateComponents(year: 2023, month: 7)
//        workout2.monthYear = calendar.date(from: components)
//
//
//
//        do {
//            try self.context.save()
//        } catch {
//            print("here")
//        }
//
//    }
    
}


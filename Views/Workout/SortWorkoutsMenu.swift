//
//  SortWorkoutsMenu.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/11/24.
//

import Foundation
import UIKit

class SortWorkoutsMenu: NSObject {
    private let homeViewController: HomeViewController
    private let workoutSortByVM: WorkoutSortByVM
    
    init(homeViewController: HomeViewController, workoutSortByVM: WorkoutSortByVM) {
        self.homeViewController = homeViewController
        self.workoutSortByVM = workoutSortByVM
    }
    
    public func getSortByActionHandler(workoutSortByType: WorkoutSortByType) -> UIActionHandler {
        let actionHandler: UIActionHandler = { _ in
            self.homeViewController.sortBy(workoutSortByType: workoutSortByType)
            }
        return actionHandler
    }
    
    public func getMenu() -> UIMenu {
        let sortByDateMenuItem = SortByMenuItem(title: "By Date",
                                                selected: self.workoutSortByVM.workoutSortByType == .date,
                                                ascending: self.workoutSortByVM.ascending,
                                                actionHandler: getSortByActionHandler(workoutSortByType: .date)).getMenuItem()
        let sortByRatingMenuItem = SortByMenuItem(title: "By Rating",
                                                selected: self.workoutSortByVM.workoutSortByType == .rating,
                                                ascending: self.workoutSortByVM.ascending,
                                                actionHandler: getSortByActionHandler(workoutSortByType: .rating)).getMenuItem()
        let sortByDurationMenuItem = SortByMenuItem(title: "By Duration",
                                                selected: self.workoutSortByVM.workoutSortByType == .duration,
                                                ascending: self.workoutSortByVM.ascending,
                                                actionHandler: getSortByActionHandler(workoutSortByType: .duration)).getMenuItem()
        let sortByAchievementsMenuItem = SortByMenuItem(title: "By Achievements",
                                                selected: self.workoutSortByVM.workoutSortByType == .achievements,
                                                ascending: self.workoutSortByVM.ascending,
                                                actionHandler: getSortByActionHandler(workoutSortByType: .achievements)).getMenuItem()
        let menu = UIMenu(preferredElementSize: .large,
                          children: [sortByDateMenuItem, sortByRatingMenuItem,
                                     sortByDurationMenuItem, sortByAchievementsMenuItem])
        return menu
    }
}

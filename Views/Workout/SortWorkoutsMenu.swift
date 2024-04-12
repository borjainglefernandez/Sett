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
    private let selectedIndex: Int
    
    init(homeViewController: HomeViewController, selectedIndex: Int) {
        self.homeViewController = homeViewController
        self.selectedIndex = selectedIndex
    }
    
    public func getMenu() -> UIMenu {
        let sortByDateMenuItem = SortByDateMenuItem(homeViewController: homeViewController,
                                                    selected: self.selectedIndex == 0).getMenuItem()
        let sortByRatingMenuItem = SortByRatingMenuItem(homeViewController: homeViewController,
                                                        selected: self.selectedIndex == 1).getMenuItem()
        let sortByDurationMenuItem = SortByDurationMenuItem(homeViewController: homeViewController,
                                                            selected: self.selectedIndex == 2).getMenuItem()
        let sortByAchievementsMenuItem = SortByAchievementsMenuItem(homeViewController: homeViewController,
                                                                    selected: self.selectedIndex == 3).getMenuItem()
        let menu = UIMenu(preferredElementSize: .large,
                          children: [sortByDateMenuItem, sortByRatingMenuItem,
                                     sortByDurationMenuItem, sortByAchievementsMenuItem])
        return menu
    }
}

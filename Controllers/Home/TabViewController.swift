//
//  TabViewController.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/7/23.
//

import UIKit

final class TabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }
    
    private func setUpTabs() {
        let homeVC = HomeViewController()
        let liftsVC = LiftsViewController()
        let statsVC = StatsViewController()
        let profileVC = ProfileViewController()
        
        homeVC.tabBarItem = UITabBarItem(title: .none,
                                       image: UIImage(systemName: "house"),
                                       tag: 1)
        liftsVC.tabBarItem = UITabBarItem(title: .none,
                                       image: UIImage(systemName: "dumbbell"),
                                       tag: 2)
        statsVC.tabBarItem = UITabBarItem(title: .none,
                                       image: UIImage(systemName: "chart.bar.fill"),
                                       tag: 3)
        profileVC.tabBarItem = UITabBarItem(title: .none,
                                       image: UIImage(systemName: "person.circle"),
                                       tag: 4)
                
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .systemGray4

        // Configure the appearance of selected tab bar items
        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.normal.iconColor = .white
        tabBarItemAppearance.selected.iconColor = .systemCyan
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.inlineLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.compactInlineLayoutAppearance = tabBarItemAppearance
        
        // Apply the customized appearance to the tab bar
        tabBarAppearance.inlineLayoutAppearance = tabBarItemAppearance
        self.tabBar.standardAppearance = tabBarAppearance
        self.tabBar.scrollEdgeAppearance = tabBarAppearance
        
        self.setViewControllers(
            [homeVC, liftsVC, statsVC, profileVC],
            animated: true
        )
    }
}

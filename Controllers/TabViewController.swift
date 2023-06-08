//
//  ViewController.swift
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
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        let liftsNav = UINavigationController(rootViewController: liftsVC)
        let statsNav = UINavigationController(rootViewController: statsVC)
        let profileNav = UINavigationController(rootViewController: profileVC)
        
        homeNav.tabBarItem = UITabBarItem(title: .none,
                                       image: UIImage(systemName: "house"),
                                       tag: 1)
        liftsNav.tabBarItem = UITabBarItem(title: .none,
                                       image: UIImage(systemName: "dumbbell"),
                                       tag: 2)
        statsNav.tabBarItem = UITabBarItem(title: .none,
                                       image: UIImage(systemName: "chart.bar.fill"),
                                       tag: 3)
        profileNav.tabBarItem = UITabBarItem(title: .none,
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
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
        tabBarAppearance.inlineLayoutAppearance = tabBarItemAppearance
        
        setViewControllers(
            [homeNav, liftsNav, statsNav, profileNav],
            animated: true
        )
    }
    
}

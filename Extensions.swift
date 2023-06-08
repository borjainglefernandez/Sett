//
//  Extensions.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/8/23.
//

import UIKit

extension UIView {
    /// Add multiple subviews
    /// - Parameter views: Variadic views
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
    
    func navigateToScreen(_ navigationController: UINavigationController?, _ viewController: UIViewController) {
        if let navigationController = navigationController {
            navigationController.setViewControllers([viewController], animated:true)
        }
    }
    
    func navigateToScreenFromTabBar(_ tabBarController: UITabBarController?, _ viewController: UIViewController) {
        // Create new root navigation controller
        let navigationController = UINavigationController()
        if let tabBarController = tabBarController {
            tabBarController.view.window?.rootViewController = navigationController
            navigateToScreen(navigationController, viewController)
        }
    }
}

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
    
    func getParentViewController(_ view: UIView) -> UIViewController? {
        var parentResponder: UIResponder? = view.next
        while parentResponder != nil {
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
            parentResponder = parentResponder?.next
        }
        return nil
    }
}

extension UITextField {
    func setCursorInsets(_ insets: UIEdgeInsets) {
        // For iOS versions prior to 13, use a custom view as the leftView to set the cursor insets
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: insets.left, height: 1))
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: insets.right, height: 1))
        self.leftView = leftView
        self.leftViewMode = .always
        self.rightView = rightView
        self.rightViewMode = .always
    }
}

extension UITableViewCell {
    // Need this in order for the color to not change when interacting with cell
    public func configureClearSelectedBackground() {
        let bgColorView = UIView()
        bgColorView.backgroundColor = .clear
        self.selectedBackgroundView = bgColorView
    }
}

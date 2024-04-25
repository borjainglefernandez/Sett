//
//  Extensions.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/8/23.
//

import SwiftUI
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
    
    func findTextField(withTag tag: Int, in view: UIView?) -> UITextField? {
        if let view = view {
            for subview in view.subviews {
                if let textField = subview as? UITextField, textField.tag == tag {
                    return textField
                } else if let foundTextField = findTextField(withTag: tag, in: subview) {
                    return foundTextField
                }
            }
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

extension UIViewController {
    func dismissKeyboardWhenTapOutside() {
       let tap: UITapGestureRecognizer = UITapGestureRecognizer( target:     self, action:    #selector(UIViewController.dismissKeyboardTouchOutside))
       tap.cancelsTouchesInView = false
       view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
       view.endEditing(true)
    }
}


extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .label
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: 17, weight: .bold)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
    }

    func restore() {
        self.backgroundView = nil
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension Workout {
    // Transient property to represent the count of achievements
       @objc var achievementsCount: Int {
           return achievements?.count ?? 0
       }
}

extension UILabel {
    func setImage(image: UIImage, fontSize: CGFloat, fontWeight: UIFont.Weight) {
        let attachment = NSTextAttachment()
               attachment.image = image
               
               let attachmentString = NSAttributedString(attachment: attachment)
               
               let attributes: [NSAttributedString.Key: Any] = [
                   .font: UIFont.systemFont(ofSize: fontSize, weight: fontWeight),
                   .foregroundColor: UIColor.label
               ]
               
               let textString = NSAttributedString(string: text ?? "", attributes: attributes)
               
               let mutableAttributedString = NSMutableAttributedString()
               mutableAttributedString.append(attachmentString)
               mutableAttributedString.append(textString)
               
               attributedText = mutableAttributedString
        }
}

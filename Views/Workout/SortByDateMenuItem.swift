//
//  SortByDateMenuItem.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/11/24.
//

import Foundation
import UIKit

class SortByDateMenuItem: NSObject {
    
    private let homeViewController: HomeViewController
    private let selected: Bool
    
    init(homeViewController: HomeViewController, selected: Bool) {
        self.homeViewController = homeViewController
        self.selected = selected
    }
    
    public func getMenuItem() -> UIAction {
        let actionHandler: UIActionHandler = { _ in
            self.homeViewController.sortByDate()
            }

        return UIAction(
            title: "By Date",
            image: self.selected ? UIImage(systemName: "checkmark") : nil,
            attributes: [],
            state: .off,
            handler: actionHandler
        )
    }
}

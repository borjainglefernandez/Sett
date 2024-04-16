//
//  SortByDateMenuItem.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/11/24.
//

import Foundation
import UIKit

class SortByMenuItem: NSObject {

    private let title: String
    private let selected: Bool
    private let ascending: Bool
    private let actionHandler: UIActionHandler

    // MARK: - Init
    init(title: String,
         selected: Bool,
         ascending: Bool,
         actionHandler: @escaping UIActionHandler) {
        self.title = title
        self.selected = selected
        self.ascending = ascending
        self.actionHandler = actionHandler
    }
    
    private func getImage() -> UIImage? {
        if self.selected {
            if self.ascending {
                return UIImage(systemName: "chevron.down")
            } else {
                return UIImage(systemName: "chevron.up")
            }
        }
        return nil
    }
    
    public func getMenuItem() -> UIAction {

        return UIAction(
            title: self.title,
            image: self.getImage(),
            attributes: [],
            state: .off,
            handler: self.actionHandler
        )
    }
}

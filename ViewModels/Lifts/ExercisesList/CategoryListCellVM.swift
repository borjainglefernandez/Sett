//
//  CategoryListCellVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/8/23.
//

import Foundation

final class CategoryListCellVM: NSObject {
    public let category: Category

     // MARK: - Init
    init(category: Category) {
        self.category = category
    }
}

//
//  CollapsableContainerTopBar.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/8/23.
//

import Foundation
import UIKit

protocol CollapsibleContainerTopBarDelegate: NSObjectProtocol {
    /// Collapse or Expand selected Month Workout Container
    ///
    /// - Parameters:
    ///   - indexPath: The index of the month workout container to expand or collapse
    ///   - collectionView: The collection view of the month workout container
    func collapseExpand(indexPath: IndexPath, collectionView: UICollectionView)
}

final class CollapsibleContainerTopBarViewModel {
    
    public let collectionView: UICollectionView
    public var isExpanded: Bool
    public let indexPath: IndexPath
    private let delegate: CollapsibleContainerTopBarDelegate
    
    init(collectionView: UICollectionView, isExpanded: Bool, indexPath: IndexPath, delegate: CollapsibleContainerTopBarDelegate) {
        self.collectionView = collectionView
        self.isExpanded = isExpanded
        self.indexPath = indexPath
        self.delegate = delegate
    }

    /// Collapse or Expand Selected Collapsible Container
    public func collapseExpand() {
        delegate.collapseExpand(indexPath: self.indexPath, collectionView: self.collectionView)
    }
}

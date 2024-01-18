//
//  SettListCellVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 10/17/23.
//

import Foundation
import UIKit

final class SettListCellVM: NSObject {
    
    public let sett: Sett
    public let settIndex: Int
    public var inputTags: [Int]
    
    // MARK: - Init
    init(sett: Sett, settIndex: Int, inputTags: [Int] = []) {
        self.sett = sett
        self.settIndex = settIndex
        self.inputTags = inputTags
    }
    
    // MARK: - Getters
    public func getPreviousSett() -> Sett? {
        // TODO: CLEAN THIS SHIT UP QUAY
        let settCollectionId = self.sett.partOf?.id ?? nil
        let exerciseSettCollections = self.sett.partOf?.exercise?.setCollections?.array ?? []
        if let settCollectionIndex = exerciseSettCollections.firstIndex(where: {($0 as? SettCollection)?.id == settCollectionId}) {
            if settCollectionIndex > 0 {
                let previousSettCollection = exerciseSettCollections[settCollectionIndex - 1] as? SettCollection
                let previousSettArray = previousSettCollection?.setts?.array ?? []
                if previousSettArray.count > self.settIndex {
                    return previousSettArray[self.settIndex] as? Sett
                }
                
            }
        }
        return nil
    }
}

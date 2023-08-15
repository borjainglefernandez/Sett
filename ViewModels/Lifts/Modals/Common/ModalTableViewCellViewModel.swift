//
//  ModalTableViewCellViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/14/23.
//

import Foundation

protocol SelectedModalTableViewCellDelegate: NSObjectProtocol {
    
    func selectDeselectCell(select: Bool)
}

class ModalTableViewCellViewModel: NSObject {
    public let title: String
    public let subTitle: String
    public let modalTableViewSelectionType: ModalTableViewSelectionType
    public var selected: Bool = false
    public var delegate: SelectedModalTableViewCellDelegate?
    
    // MARK: - Init
    init(title: String, subTitle: String, modalTableViewSelectionType: ModalTableViewSelectionType) {
        self.title = title
        self.subTitle = subTitle
        self.modalTableViewSelectionType = modalTableViewSelectionType
    }
    
    // MARK: - Actions
    public func setDelegate(delegate: SelectedModalTableViewCellDelegate) {
        self.delegate = delegate
    }
    
    public func selectDeselectCell(select: Bool) {
        self.selected = select
        self.delegate?.selectDeselectCell(select: select)
    }
}

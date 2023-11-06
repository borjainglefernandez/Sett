//
//  SettNotesInputVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 11/2/23.
//

import Foundation
import UIKit

class SettNotesInputVM: NSObject {
    public let sett: Sett
    public var settListCell: SettListCell?
    public let maxNotesCharacters = 30

    // MARK: - Init
    init(sett: Sett) {
        self.sett = sett
    }
    
    // MARK: - Configurations
    public func setSettListCell(to settListCell: SettListCell) {
        self.settListCell = settListCell
    }
    
    // MARK: - Actions
    public func viewNotes() {
        if let settListCell = self.settListCell, let parentViewController = settListCell.getParentViewController(settListCell) {
            let notesViewController = NotesViewController(viewModel: self)
            parentViewController.present(notesViewController, animated: true)
        }
    }
    
}

// MARK: - Notes View Protocol
extension SettNotesInputVM: NotesViewProtocol {
    public func getNotes() -> String {
        return self.sett.notes ?? ""
    }

    public func getUITextViewDelegate() -> UITextViewDelegate {
        return self
    }
}

// MARK: - UITextFieldDelegate
extension SettNotesInputVM: UITextFieldDelegate {
        
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.sett.notes = textField.text
        CoreDataBase.save()
    }

//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if let text = textField.text,
//           text.count >= self.maxNotesCharacters {
//            textField.text = (text as NSString).substring(to: self.maxNotesCharacters) + "..."
//            }
//        return true
//
//    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.sett.notes?.count ?? 0 >= self.maxNotesCharacters {
            self.viewNotes()
        }
    }
}

// MARK: - UITextViewDelegate
extension SettNotesInputVM: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        self.settListCell?.setNotes(to: textView.text)
        self.sett.notes = textView.text
        CoreDataBase.save()
    }
}

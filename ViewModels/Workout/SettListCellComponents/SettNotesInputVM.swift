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
    
    /// Whether or not notes are actively presented
    /// - Returns: True if notes modal actively presented already
    public func notesModalActivelyPresented() -> Bool {
        if let settListCell = self.settListCell, settListCell.getParentViewController(settListCell)?.presentedViewController != nil {
            return true
        }
        return false
    }
    
    /// Whether or not notes modal should be presented
    /// - Returns: True if:
    ///   1.) Notes exceed certain character limit
    ///   2.) Notes modal not already being presented
    ///     ... False otherwise
    public func shouldViewNotesModal() -> Bool {
        return self.sett.notes?.count ?? 0 >= self.maxNotesCharacters && !self.notesModalActivelyPresented()
    }
    
    public func viewNotesModalIfNecessary() {
        // Check if notes modal should be shown
        if self.shouldViewNotesModal() {
            // If so, show it
            if let settListCell = self.settListCell, let parentViewController = settListCell.getParentViewController(settListCell) {
                
                let notesViewController = NotesViewController(viewModel: self)
                parentViewController.present(notesViewController, animated: true)
            }
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
        self.viewNotesModalIfNecessary()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.viewNotesModalIfNecessary()
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

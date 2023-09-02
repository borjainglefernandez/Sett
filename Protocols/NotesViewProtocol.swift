//
//  NotesViewProtocol.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 9/2/23.
//

import Foundation
import UIKit

protocol NotesViewProtocol {
    /// - Returns: The text to populate the notes view or empty string if none
    func getNotes() -> String
    
    /// - Returns: The text view delegate to handle text changes in notes view
    func getUITextViewDelegate() -> UITextViewDelegate
}

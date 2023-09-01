//
//  SearchBar.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/31/23.
//

import UIKit

class SearchBar: UISearchBar {
    
    // MARK: - Init
    init(frame: CGRect = .zero, searchBarDelegate: UISearchBarDelegate) {
            super.init(frame: frame)
            translatesAutoresizingMaskIntoConstraints = false
            backgroundImage = UIImage()
            searchTextField.backgroundColor = .systemGray4
            searchTextField.layer.cornerRadius = 15
            searchTextField.layer.masksToBounds = true
            searchTextField.placeholder = "Search"
            delegate = searchBarDelegate
            self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

}

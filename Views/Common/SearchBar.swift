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
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundImage = UIImage()
        self.searchTextField.backgroundColor = .systemGray4
        self.searchTextField.layer.cornerRadius = 15
        self.searchTextField.layer.masksToBounds = true
        self.searchTextField.placeholder = "Search"
        self.delegate = searchBarDelegate
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

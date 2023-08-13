//
//  RoutinesView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/30/23.
//

import UIKit

class RoutinesView: UIView {
    private let routinesTable: UITableView = {
       let routinesTable = UITableView()
        routinesTable.backgroundColor = .red
        routinesTable.translatesAutoresizingMaskIntoConstraints = false
        return routinesTable
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(self.routinesTable)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.routinesTable.topAnchor.constraint(equalTo: topAnchor),
            self.routinesTable.leftAnchor.constraint(equalTo: leftAnchor),
            self.routinesTable.rightAnchor.constraint(equalTo: rightAnchor),
            self.routinesTable.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        ])
    }

}

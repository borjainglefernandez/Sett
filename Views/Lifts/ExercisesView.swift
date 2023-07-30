//
//  ExercisesView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/30/23.
//

import UIKit

class ExercisesView: UIView {

    private let exercisesTable: UITableView = {
       let exercisesTable = UITableView()
        exercisesTable.backgroundColor = .yellow
        exercisesTable.translatesAutoresizingMaskIntoConstraints = false
        return exercisesTable
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(self.exercisesTable)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.exercisesTable.topAnchor.constraint(equalTo: topAnchor),
            self.exercisesTable.leftAnchor.constraint(equalTo: leftAnchor),
            self.exercisesTable.rightAnchor.constraint(equalTo: rightAnchor),
            self.exercisesTable.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}

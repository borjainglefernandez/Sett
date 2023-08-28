//
//  RoutineExerciseListCell.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/28/23.
//

import UIKit

class RoutineExerciseListCell: UICollectionViewCell {

    static let cellIdentifier = "RoutineExerciseListCell"
    
    private let menuBar = MenuBar()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.layer.cornerRadius = 15

        self.addSubviews(self.menuBar)
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported constructor")
    }
    
    // MARK: - LifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.menuBar.topAnchor.constraint(equalTo: self.topAnchor),
            self.menuBar.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.menuBar.rightAnchor.constraint(equalTo: self.rightAnchor),
        ])
    }
    
    // MARK: - Configurations
    public func configure(with viewModel: RoutineExerciseListCellViewModel) {
    }
    
    
}

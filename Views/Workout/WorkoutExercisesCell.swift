//
//  WorkoutExerciseCell.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 10/17/23.
//

import UIKit

class WorkoutExercisesCell: UICollectionViewCell {
    static let cellIdentifier = "WorkoutExerciseCell"

    // Top bar of the category list container
    public let collapsibleContainerTopBar: CollapsibleContainerTopBar = CollapsibleContainerTopBar()

    // List of all the routines for a particular category
    public let settListView: SettListView = SettListView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.layer.cornerRadius = 15

        self.addSubviews(self.collapsibleContainerTopBar, self.settListView)
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported constructor")
    }
    
    // MARK: - LifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        self.collapsibleContainerTopBar.setTitleLabelText(title: "")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.collapsibleContainerTopBar.heightAnchor.constraint(equalToConstant: 30),
            self.collapsibleContainerTopBar.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.collapsibleContainerTopBar.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            self.settListView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1, constant: -30),
            self.settListView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.settListView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.settListView.leftAnchor.constraint(equalTo: self.leftAnchor)
        ])
    }
    
    // MARK: - Configurations
    public func configure(
        with viewModel: WorkoutExercisesCellVM,
        at indexPath: IndexPath,
        for collectionView: UICollectionView,
        isExpanded: Bool,
        delegate: CollapsibleContainerTopBarDelegate) {
        
        // Configure view model of collapsible top bar and title
        let collapsibleContainerTopBarVM = CollapsibleContainerTopBarVM(
            collectionView: collectionView,
            isExpanded: isExpanded,
            indexPath: indexPath,
            delegate: delegate)
        self.collapsibleContainerTopBar.configure(with: collapsibleContainerTopBarVM)
        self.collapsibleContainerTopBar.setTitleLabelText(title: "\(String(describing: viewModel.exercise.name))")
        
        // Configure Sett list view with view model
//        self.settListView.configure(with: RoutineListVM(routines: viewModel.routines))
    }
}

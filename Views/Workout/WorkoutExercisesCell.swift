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
            self.collapsibleContainerTopBar.topAnchor.constraint(equalTo: self.topAnchor),
            
            self.settListView.topAnchor.constraint(equalTo: self.collapsibleContainerTopBar.bottomAnchor),
            self.settListView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -30),
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
            self.collapsibleContainerTopBar.setTitleLabelText(title: viewModel.workoutExercise.exercise?.name ?? "")
        
        // Configure Sett list view with view model
        guard let settCollection = viewModel.workoutExercise.settCollection else {
            return
        }
        
        self.settListView.configure(with: SettListVM(settCollection: settCollection, isExpanded: isExpanded))
    }
}

//
//  MonthListCell.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/17/23.
//

import UIKit

final class MonthListCell: UICollectionViewCell {
    
    static let cellIdentifier = "MonthListCell"
    
    public let collapsibleContainerTopBar: CollapsibleContainerTopBar = CollapsibleContainerTopBar()
    
    public let workoutListView = WorkoutListView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.layer.cornerRadius = 15

        self.addSubviews(self.collapsibleContainerTopBar, self.workoutListView)
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
            
            self.workoutListView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1, constant: -30),
            self.workoutListView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.workoutListView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.workoutListView.leftAnchor.constraint(equalTo: self.leftAnchor)
        ])
    }
    
    // MARK: - Configurations
    public func configure(with viewModel: MonthListCellVM,
                          at indexPath: IndexPath,
                          for collectionView: UICollectionView,
                          isExpanded: Bool,
                          delegate: CollapsibleContainerTopBarDelegate) {
        // Populate title label text
        let workoutSuffix = viewModel.numWorkouts == 1 ? "Workout" : "Workouts"
        self.collapsibleContainerTopBar.setTitleLabelText(title: "\(viewModel.monthYearFormatted) - \(viewModel.numWorkouts) \(workoutSuffix)")
        
        // Configure view model of collapsible top bar
        let collapsibleContainerTopBarVM = CollapsibleContainerTopBarVM(
            collectionView: collectionView,
            isExpanded: isExpanded,
            indexPath: indexPath,
            delegate: delegate)
        self.collapsibleContainerTopBar.configure(with: collapsibleContainerTopBarVM)
        
        // Extract month and year then configure view model of workout
        guard let month = Int(viewModel.monthYear.components(separatedBy: "/")[0]),
              let year = Int(viewModel.monthYear.components(separatedBy: "/")[1]) else {
                  fatalError("Could not get month or year from string")
              }
        let workoutListVM = WorkoutListVM(workoutSortByVM: viewModel.workoutSortByVM, month: month, year: year)
        self.workoutListView.configure(with: workoutListVM)
    }
}

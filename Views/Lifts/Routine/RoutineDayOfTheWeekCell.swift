//
//  RoutineDayOfTheWeekCell.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 9/10/23.
//

import UIKit

class RoutineDayOfTheWeekCell: UICollectionViewCell {
    
    static let cellIdentifier = "RoutineDayOfTheWeekCell"
    
    // Top bar of the category list container
    public let collapsibleContainerTopBar: CollapsibleContainerTopBar = CollapsibleContainerTopBar()

    // List of all the routines for a particular category
    public let routinesListView: RoutineListView = RoutineListView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.layer.cornerRadius = 15

        self.addSubviews(self.collapsibleContainerTopBar, self.routinesListView)
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
            
            self.routinesListView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1, constant: -30),
            self.routinesListView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.routinesListView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.routinesListView.leftAnchor.constraint(equalTo: self.leftAnchor),
        ])
    }
    
    // MARK: - Configurations
    public func configure(with viewModel: RoutineDayOfTheWeekCellVM, at indexPath: IndexPath, for collectionView: UICollectionView, isExpanded: Bool, delegate: CollapsibleContainerTopBarDelegate) {
        
        // Configure view model of collapsible top bar and title
        let collapsibleContainerTopBarViewModel = CollapsibleContainerTopBarViewModel(collectionView: collectionView, isExpanded: isExpanded, indexPath: indexPath, delegate: delegate)
        self.collapsibleContainerTopBar.configure(with: collapsibleContainerTopBarViewModel)
        self.collapsibleContainerTopBar.setTitleLabelText(title: "\(viewModel.title)")
        
        // Configure Routines list view with view model
        self.routinesListView.configure(with: RoutineListViewModel(routines: viewModel.routines))
    }
}

//
//  MonthListCell.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/17/23.
//

import UIKit

protocol ExpandedCellDelegate: NSObjectProtocol {
    /// Collapse or Expand selected Month Workout Container
    ///
    /// - Parameters:
    ///   - indexPath: The index of the month workout container to expand or collapse
    ///   - collectionView: The collection view of the month workout container
    func collapseExpand(indexPath:IndexPath, collectionView: UICollectionView)
}

final class MonthListCell: UICollectionViewCell {
    
    static let cellIdentifier = "MonthListCell"
    
    weak var delegate:ExpandedCellDelegate?
    
    public var indexPath:IndexPath!
    
    // Top bar of the month workout list container
    private let topBar: UIView = {
        let topBar = UIView()
        topBar.translatesAutoresizingMaskIntoConstraints = false
        topBar.backgroundColor = .systemGray4
        return topBar
    }()
    
    // Title label for the container
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .label
        titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    // Button to expand or collapse cell
    private let expandCollapseButton: UIButton = {
        let expandCollapseButton = UIButton(type: .custom)
        var config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 17, weight: .bold))
        expandCollapseButton.tintColor = .label
        expandCollapseButton.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        expandCollapseButton.translatesAutoresizingMaskIntoConstraints = false
        return expandCollapseButton
    }()
    
    public let monthWorkoutListView = MonthWorkoutListView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.layer.cornerRadius = 15
    
        self.expandCollapseButton.addTarget(self, action: #selector(collapseExpand), for: .touchUpInside)

        self.addSubviews(topBar, titleLabel, expandCollapseButton, monthWorkoutListView)
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported constructor")
    }
    
    // MARK: - LifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.topBar.heightAnchor.constraint(equalToConstant: 30),
            self.topBar.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.topBar.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            self.titleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 2),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            
            self.expandCollapseButton.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            self.expandCollapseButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            
            self.monthWorkoutListView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1, constant: -30),
            self.monthWorkoutListView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.monthWorkoutListView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.monthWorkoutListView.leftAnchor.constraint(equalTo: self.leftAnchor),
        ])
    }
    
    // MARK: - Configurations
    public func configure(with viewModel: MonthListCellViewModel) {
        // Populate title label text
        let workoutSuffix = viewModel.numWorkouts == 1 ? "Workout" : "Workouts"
        self.titleLabel.text = "\(viewModel.monthName) - \(viewModel.numWorkouts) \(workoutSuffix)"
        
        // Extract month and year then configure view model of workout
        guard let month = Int(viewModel.monthName.components(separatedBy: "/")[0]),
              let year = Int(viewModel.monthName.components(separatedBy: "/")[1]) else {
                  fatalError("Could not get month or year from string")
              }
        let monthWorkoutListViewModel = MonthWorkoutListViewModel(month: month, year: year)
        self.monthWorkoutListView.configure(with: monthWorkoutListViewModel)
    }
    
    // MARK: - Actions
    
    // Expand and collapse month list cell
    @objc func collapseExpand() {
        guard let collectionView = superview as? UICollectionView else {
            return
        }
        if let delegate = self.delegate {
            delegate.collapseExpand(indexPath: self.indexPath, collectionView: collectionView)
        }
    }
    
    // Show or hide month list view depending on whether or not it was expanded
    public func showHideMonthListView(isExpanded: Bool) {
        topBar.layer.cornerRadius = 15
        monthWorkoutListView.isHidden = !isExpanded // Hide or show view
        
        // Change corner radii and icon depending on whether or not showing or hiding
        var iconImage: UIImage?
        if isExpanded {
            topBar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            iconImage = UIImage(systemName: "chevron.up")
        } else {
            topBar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            iconImage = UIImage(systemName: "chevron.down")
        }
        self.expandCollapseButton.setImage(iconImage, for: .normal)
    }
}

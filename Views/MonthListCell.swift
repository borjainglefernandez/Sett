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
        contentView.layer.cornerRadius = 15
        addSubviews(topBar, titleLabel, expandCollapseButton, monthWorkoutListView)
        expandCollapseButton.addTarget(self, action: #selector(collapseExpand), for: .touchUpInside)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported constructor")
    }
    
    // MARK: - LifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    // MARK: - Constrains
    private func addConstraints() {
        NSLayoutConstraint.activate([
            topBar.heightAnchor.constraint(equalToConstant: 30),
            topBar.leftAnchor.constraint(equalTo: leftAnchor),
            topBar.rightAnchor.constraint(equalTo: rightAnchor),
            
            titleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: leftAnchor, multiplier: 2),
            titleLabel.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            
            expandCollapseButton.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            expandCollapseButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            
            monthWorkoutListView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1, constant: -30),            monthWorkoutListView.bottomAnchor.constraint(equalTo: bottomAnchor),
            monthWorkoutListView.rightAnchor.constraint(equalTo: rightAnchor),
            monthWorkoutListView.leftAnchor.constraint(equalTo: leftAnchor),
        ])
    }
    
    // MARK: - Configurations
    public func configure(with viewModel: MonthListCellViewModel) {
        titleLabel.text = "\(viewModel.monthName) - \(viewModel.numWorkouts) Workouts"
        
        guard let month = Int(viewModel.monthName.components(separatedBy: "/")[0]),
              let year = Int(viewModel.monthName.components(separatedBy: "/")[1]) else {
                  fatalError("Could not get month or year from string")
              }
        
        let monthWorkoutListViewModel = MonthWorkoutListViewModel(month: month, year: year)
        monthWorkoutListView.configure(with: monthWorkoutListViewModel)
    }
    
    // MARK: - Actions
    @objc func collapseExpand() {
        guard let collectionView = superview as? UICollectionView else {
            return
        }
        if let delegate = self.delegate {
            delegate.collapseExpand(indexPath: self.indexPath, collectionView: collectionView)
        }

    }
    
    public func showHideMonthListView(isExpanded: Bool) {
        var iconImage: UIImage?
        topBar.layer.cornerRadius = 15
        monthWorkoutListView.isHidden = !isExpanded
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

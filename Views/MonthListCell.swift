//
//  MonthWorkoutListCell.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/17/23.
//

import UIKit

protocol ExpandedCellDelegate: NSObjectProtocol{
    func collapseExpand(indexPath:IndexPath, collectionView: UICollectionView)
}

final class MonthListCell: UICollectionViewCell {
    static let cellIdentifier = "MonthListCell"
    weak var delegate:ExpandedCellDelegate?
    public var indexPath:IndexPath!
    
    private let topBox: UIView = {
        let topBox = UIView()
        topBox.translatesAutoresizingMaskIntoConstraints = false
        topBox.backgroundColor = .systemGray4
        return topBox
    }()
    
    private let cellLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toggleArrowButton: UIButton = {
        let iconButton = UIButton(type: .custom)
        var config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 17, weight: .bold))
        iconButton.tintColor = .label
        iconButton.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        iconButton.translatesAutoresizingMaskIntoConstraints = false
        
        return iconButton
    }()
    
    public let monthWorkoutListView = MonthWorkoutListView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 15
        addSubviews(topBox, cellLabel, toggleArrowButton, monthWorkoutListView)
        toggleArrowButton.addTarget(self, action: #selector(collapseExpand), for: .touchUpInside)
        addConstraints()
    }
    
    @objc func collapseExpand() {
        guard let collectionView = superview as? UICollectionView else {
            return
        }
        if let delegate = self.delegate {
            delegate.collapseExpand(indexPath: self.indexPath, collectionView: collectionView)
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported constructor")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellLabel.text = nil
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            topBox.heightAnchor.constraint(equalToConstant: 30),
            topBox.leftAnchor.constraint(equalTo: leftAnchor),
            topBox.rightAnchor.constraint(equalTo: rightAnchor),
            cellLabel.leftAnchor.constraint(equalToSystemSpacingAfter: leftAnchor, multiplier: 2),
            cellLabel.centerYAnchor.constraint(equalTo: topBox.centerYAnchor),
            toggleArrowButton.centerYAnchor.constraint(equalTo: topBox.centerYAnchor),
            toggleArrowButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            monthWorkoutListView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1, constant: -30),            monthWorkoutListView.bottomAnchor.constraint(equalTo: bottomAnchor),
            monthWorkoutListView.rightAnchor.constraint(equalTo: rightAnchor),
            monthWorkoutListView.leftAnchor.constraint(equalTo: leftAnchor),
        ])
    }
    
    public func showHideMonthListView(isExpanded: Bool) {
        var iconImage: UIImage?
        topBox.layer.cornerRadius = 15
        monthWorkoutListView.isHidden = !isExpanded
        if isExpanded {
            topBox.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            iconImage = UIImage(systemName: "chevron.up")
        } else {
            topBox.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            iconImage = UIImage(systemName: "chevron.down")
        }
        self.toggleArrowButton.setImage(iconImage, for: .normal)
        
    }
    
    public func configure(with viewModel: MonthListCellViewModel) {
        cellLabel.text = "\(viewModel.monthName) - \(viewModel.numWorkouts) Workouts"
        
        guard let month = Int(viewModel.monthName.components(separatedBy: "/")[0]),
              let year = Int(viewModel.monthName.components(separatedBy: "/")[1]) else {
                  fatalError("Could not get month or year from string")
              }
        
        let monthWorkoutListViewModel = MonthWorkoutListViewModel(month: month, year: year)
        monthWorkoutListView.configure(with: monthWorkoutListViewModel)
    }
    
    
}

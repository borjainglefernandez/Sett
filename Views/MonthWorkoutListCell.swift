//
//  MonthWorkoutListCell.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/17/23.
//

import UIKit

final class MonthWorkoutListCell: UICollectionViewCell {
    static let cellIdentifier = "MonthWorkoutListCell"
    
    private let cellLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toggleArrowButton: UIButton = {
        let iconButton = UIButton(type: .custom)
        let iconImage = UIImage(systemName: "chevron.right")
        var config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 14.0, weight: .bold))
        iconButton.tintColor = .white
        iconButton.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        iconButton.setImage(iconImage, for: .normal)
        iconButton.translatesAutoresizingMaskIntoConstraints = false
        return iconButton
    }()
    
    private let monthWorkoutListView = MonthWorkoutListView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray4
        contentView.layer.cornerRadius = 15
        addSubview(cellLabel)
        addSubview(toggleArrowButton)
        addSubview(monthWorkoutListView)
        addConstraints()
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
            cellLabel.leftAnchor.constraint(equalToSystemSpacingAfter: leftAnchor, multiplier: 2),
            cellLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            
            toggleArrowButton.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 0.8),
            toggleArrowButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            
            monthWorkoutListView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9),
            monthWorkoutListView.bottomAnchor.constraint(equalTo: bottomAnchor),
            monthWorkoutListView.rightAnchor.constraint(equalTo: rightAnchor),
            monthWorkoutListView.leftAnchor.constraint(equalTo: leftAnchor),
        ])
    }
    
    public func configure(with viewModel: MonthWorkoutListCellViewModel) {
        cellLabel.text = "\(viewModel.monthName) - \(viewModel.numWorkouts) Workouts"
    }
    
    
}

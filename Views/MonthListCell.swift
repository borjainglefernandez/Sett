//
//  MonthWorkoutListCell.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/17/23.
//

import UIKit

final class MonthListCell: UICollectionViewCell {
    static let cellIdentifier = "MonthListCell"
    
    private var isCollapsed: Bool = false
    
    private let topBox: UIView = {
        let topBox = UIView()
        topBox.translatesAutoresizingMaskIntoConstraints = false
        topBox.backgroundColor = .systemGray4
        topBox.layer.cornerRadius = 15
        topBox.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
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
        contentView.layer.cornerRadius = 15
        addSubviews(topBox, cellLabel, toggleArrowButton, monthWorkoutListView)
        toggleArrowButton.addTarget(self, action: #selector(collapseExpand), for: .touchUpInside)

        addConstraints()
    }
    
    @objc func collapseExpand() {
       print("Here")
        if !self.isCollapsed {
            monthWorkoutListView.isHidden = true
            monthWorkoutListView.layer.opacity = 0
        } else {
            monthWorkoutListView.isHidden = false
            monthWorkoutListView.layer.opacity = 1
        }
        
        self.isCollapsed = !self.isCollapsed

        
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
            topBox.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1),
            topBox.leftAnchor.constraint(equalTo: leftAnchor),
            topBox.rightAnchor.constraint(equalTo: rightAnchor),
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

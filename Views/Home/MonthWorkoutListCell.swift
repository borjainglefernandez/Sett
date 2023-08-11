//
//  MonthWorkoutListCell.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/22/23.
//

import UIKit

final class MonthWorkoutListCell: UITableViewCell {
    static let cellIdentifier = "MonthWorkoutTableViewCell"
    
    // Each individual cell container
    private let containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .systemGray2.withAlphaComponent(0.6)
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = 15
        return containerView
    }()
    
    // Display day of the month using a custom calendar icon
    private let calendarDayView = CalendarDayView()

    // Display title of the workout
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .label
        titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 1
        titleLabel.lineBreakMode = .byTruncatingTail
        return titleLabel
    }()
    
    // Display star rating of the workout
    private let starRating = StarRating(frame: .zero, interactable: false, starSize: 20, starMargin: 0.5)
    
    // Display number of achievements of the workout
    private let achievementsNumberView = AchievementsNumberView()
    
    // Display duration of the workout
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 8, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear // Allows for customisability of cell
        self.configureClearSelectedBackground()
        
        self.contentView.addSubviews(self.containerView, self.calendarDayView, self.titleLabel, self.starRating, self.achievementsNumberView, self.durationLabel)
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - LifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        self.calendarDayView.day = nil
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: self.topAnchor),
            self.containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.containerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.985),
            self.containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.985),
            
            self.calendarDayView.leftAnchor.constraint(equalToSystemSpacingAfter: self.containerView.leftAnchor, multiplier: 1.5),
            self.calendarDayView.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 0.8),
            
            self.titleLabel.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            self.titleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.calendarDayView.rightAnchor, multiplier: 6),
            self.titleLabel.widthAnchor.constraint(equalToConstant: 100),
            
            self.starRating.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            self.starRating.leftAnchor.constraint(equalTo: self.titleLabel.rightAnchor, constant: 10),
    
            self.achievementsNumberView.leftAnchor.constraint(equalTo: self.starRating.rightAnchor, constant: 25),
            self.achievementsNumberView.heightAnchor.constraint(equalToConstant: 25),
            self.achievementsNumberView.widthAnchor.constraint(equalToConstant: 25),
            self.achievementsNumberView.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            
            self.durationLabel.leftAnchor.constraint(equalTo: self.achievementsNumberView.rightAnchor, constant: 25),
            self.durationLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    // MARK: - Configurations
    public func configure(with viewModel: MonthWorkoutListCellViewModel) {
        if let startTime = viewModel.workout.startTime {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day], from: startTime)
            if let day = components.day {
                self.titleLabel.text =  viewModel.workout.title
                self.starRating.starRating.rating = viewModel.workout.rating
                self.calendarDayView.day = "\(String(describing: day))"
                self.achievementsNumberView.numAchievements = 3
                self.durationLabel.text = "45 min"
                
            }
        }
    }
}

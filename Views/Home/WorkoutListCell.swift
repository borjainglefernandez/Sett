//
//  MonthWorkoutListCell.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/22/23.
//

import UIKit

final class WorkoutListCell: UITableViewCell {
    
    static let cellIdentifier = "WorkoutListCell"
    
    private var timeElapsedTimer: Timer? // Timer for updating time elapsed in an ongoing workout
    private var viewModel: WorkoutListCellVM?
    
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
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byTruncatingTail
        return titleLabel
    }()
    
    // Display star rating of the workout
    lazy var starRating = StarRating(frame: .zero, interactable: false, starSize: self.bounds.width / 17.5, starMargin: 0)
    
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
        
        self.contentView.addSubviews(self.containerView,
                                     self.calendarDayView,
                                     self.titleLabel,
                                     self.starRating,
                                     self.achievementsNumberView,
                                     self.durationLabel)
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - LifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        self.durationLabel.textColor = .label
        self.timeElapsedTimer?.invalidate()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let isOngoing = self.viewModel?.workout.isOngoing,
           isOngoing,
           self.viewModel != nil {
            self.startTimer()
        }
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: self.topAnchor),
            self.containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.containerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.985),
            self.containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.985),
            
            self.calendarDayView.leftAnchor.constraint(equalToSystemSpacingAfter: self.containerView.leftAnchor, multiplier: 1.2),
            self.calendarDayView.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 0.8),
            
            self.titleLabel.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            self.titleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.calendarDayView.rightAnchor, multiplier: 5.5),
            self.titleLabel.widthAnchor.constraint(equalTo: self.containerView.widthAnchor, multiplier: 0.3),
            
            self.starRating.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            self.starRating.leftAnchor.constraint(equalToSystemSpacingAfter: self.titleLabel.rightAnchor, multiplier: 1.2),
    
            self.achievementsNumberView.leftAnchor.constraint(equalToSystemSpacingAfter: self.starRating.rightAnchor, multiplier: 1.2),
            self.achievementsNumberView.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 0.6),
            self.achievementsNumberView.widthAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 0.6),
            self.achievementsNumberView.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            
            self.durationLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.achievementsNumberView.rightAnchor, multiplier: 1.2),
            self.durationLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    // MARK: - Configurations
    public func configure(with viewModel: WorkoutListCellVM) {
        self.viewModel = viewModel
        self.titleLabel.text =  viewModel.workout.title
        self.starRating.starRating.rating = viewModel.workout.rating
        self.achievementsNumberView.achievementsNumberLabel.text = String(describing: "2")
        
        // Duration label
        if viewModel.workout.isOngoing {
            self.durationLabel.textColor = .systemCyan
            self.startTimer()
        } else {
            self.timeElapsedTimer?.invalidate()
        }
        self.durationLabel.text = viewModel.calculateWorkoutTime()
        
        // Calendar day label
        if let startTime = viewModel.workout.startTime {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day], from: startTime)
            if let day = components.day {
                self.calendarDayView.calendarLabel.text = "\(String(describing: day))"
                
            }
        }
    }
    
    private func startTimer() {
        self.timeElapsedTimer = Timer.scheduledTimer(
            timeInterval: 60, target: self,
            selector: #selector(updateTimeElapsed), userInfo: nil, repeats: true)

    }
    
    // MARK: - Actions
    @objc private func updateTimeElapsed() {
        if let viewModel = self.viewModel {
            self.durationLabel.text = viewModel.calculateWorkoutTime()
        }
    }
}

//
//  MonthWorkoutTableViewCell.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/22/23.
//

import UIKit
import Cosmos

class MonthWorkoutListCell: UITableViewCell {
    static let cellIdentifier = "MonthWorkoutTableViewCell"
    
    private let starRating: CosmosView = {
        let starRating = CosmosView()
        starRating.translatesAutoresizingMaskIntoConstraints = false
        starRating.settings.filledColor = .systemCyan
        starRating.settings.emptyColor = .systemGray
        starRating.settings.emptyBorderColor = .systemGray2
        starRating.settings.filledBorderColor = .systemGray2
        starRating.settings.emptyBorderWidth = 0.5
        starRating.settings.filledBorderWidth = 0.5
        starRating.rating = 4.5
        starRating.settings.fillMode = .half
        starRating.settings.starSize = 20
        starRating.settings.starMargin = 0.5
        starRating.isUserInteractionEnabled = false
        return starRating
    }()
    
    private let containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .systemGray2.withAlphaComponent(0.6)
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = 15
        return containerView
    }()
    
    private let leftCircle: UIView = {
        let leftCircle = UIView()
        leftCircle.translatesAutoresizingMaskIntoConstraints = false
        leftCircle.layer.cornerRadius = 2
        leftCircle.layer.masksToBounds = true
        leftCircle.backgroundColor = .white
        leftCircle.layer.borderWidth = 1
        leftCircle.layer.borderColor = UIColor.systemGray.cgColor
        
        return leftCircle
    }()
    
    private let rightCircle: UIView = {
        let rightCircle = UIView()
        rightCircle.translatesAutoresizingMaskIntoConstraints = false
        rightCircle.layer.cornerRadius = 2
        rightCircle.layer.masksToBounds = true
        rightCircle.backgroundColor = .white
        rightCircle.layer.borderWidth = 1
        rightCircle.layer.borderColor = UIColor.systemGray.cgColor
        
        return rightCircle
    }()
    
    private let topCalendarView: UIView = {
        let topStrip = UIView()
        topStrip.translatesAutoresizingMaskIntoConstraints = false
        topStrip.backgroundColor = .systemGray4
        topStrip.layer.cornerRadius = 10
        topStrip.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return topStrip
    }()
    
    private let bottomCalendarView: UIView = {
        let bottomStrip = UIView()
        bottomStrip.translatesAutoresizingMaskIntoConstraints = false
        bottomStrip.backgroundColor = .systemGray.withAlphaComponent(0.44)
        bottomStrip.layer.cornerRadius = 10
        bottomStrip.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return bottomStrip
    }()
    
    private let calendarLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Push Day 1"
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        contentView.addSubviews(containerView, topCalendarView, bottomCalendarView, leftCircle, rightCircle, calendarLabel, titleLabel, starRating)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initializer")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        calendarLabel.text = nil
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.heightAnchor.constraint(equalTo: heightAnchor),
            containerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.98),
            
            topCalendarView.leftAnchor.constraint(equalToSystemSpacingAfter: containerView.leftAnchor, multiplier: 2),
            topCalendarView.heightAnchor.constraint(equalToConstant: 8),
            topCalendarView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 6),
            topCalendarView.widthAnchor.constraint(equalToConstant: 32),
            
            bottomCalendarView.centerXAnchor.constraint(equalTo: topCalendarView.centerXAnchor),
            bottomCalendarView.topAnchor.constraint(equalTo: topCalendarView.bottomAnchor),
            bottomCalendarView.heightAnchor.constraint(equalToConstant: 22),
            bottomCalendarView.widthAnchor.constraint(equalToConstant: 30),
            
            calendarLabel.centerXAnchor.constraint(equalTo: bottomCalendarView.centerXAnchor),
            calendarLabel.centerYAnchor.constraint(equalTo: bottomCalendarView.centerYAnchor),
            
            leftCircle.heightAnchor.constraint(equalToConstant: 4),
            leftCircle.widthAnchor.constraint(equalToConstant: 4),
            leftCircle.centerXAnchor.constraint(equalTo: topCalendarView.centerXAnchor, constant: -6),
            leftCircle.centerYAnchor.constraint(equalTo: topCalendarView.centerYAnchor),
            
            rightCircle.heightAnchor.constraint(equalToConstant: 4),
            rightCircle.widthAnchor.constraint(equalToConstant: 4),
            rightCircle.centerXAnchor.constraint(equalTo: topCalendarView.centerXAnchor, constant: 6),
            rightCircle.centerYAnchor.constraint(equalTo: topCalendarView.centerYAnchor),
            
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            titleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: bottomCalendarView.rightAnchor, multiplier: 3),
            titleLabel.widthAnchor.constraint(equalToConstant: 100),
            
            starRating.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            starRating.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 10),
    
            
            
            
        ])
    }
    
    public func configure(with viewModel: MonthWorkoutListCellViewModel) {
        if let startTime = viewModel.workout.startTime {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day], from: startTime)
            if let day = components.day {
                calendarLabel.text = "\(String(describing: day))"
                
            }
        }
    }
}

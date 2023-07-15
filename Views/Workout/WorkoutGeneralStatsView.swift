//
//  WorkoutGeneralStatsView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/14/23.
//

import UIKit

final class WorkoutGeneralStatsView: UIView {

    private let viewModel: WorkoutViewModel
    
    
    // Top bar of the general stats view container
    private let topBar: UIView = {
        let topBar = UIView()
        topBar.translatesAutoresizingMaskIntoConstraints = false
        topBar.backgroundColor = .systemGray4
        topBar.layer.cornerRadius = 15
        topBar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return topBar
    }()
    
    private let container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .systemGray3.withAlphaComponent(0.44)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = 15
        container.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return container
    }()
    
    private let ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.textColor = .label
        ratingLabel.font = .systemFont(ofSize: 17, weight: .regular)
        ratingLabel.text = "Rating"
        return ratingLabel
    }()
    
    private let rating = StarRating(frame: .zero, interactable: true, starSize: 25, starMargin: 0.5)
    
    private let divider: UIView = {
        let divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .white
        return divider
    }()
    
    private let startTimeLabel: UILabel = {
        let startTimeLabel = UILabel()
        startTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        startTimeLabel.textColor = .label
        startTimeLabel.font = .systemFont(ofSize: 17, weight: .regular)
        startTimeLabel.text = "Start Time"
        return startTimeLabel
    }()
    
    private let startTimePicker: UIDatePicker = {
        let startTimePicker = UIDatePicker()
        startTimePicker.translatesAutoresizingMaskIntoConstraints = false
        startTimePicker.datePickerMode = .dateAndTime
        return startTimePicker
        
    }()
    
    private let dividerStartTime: UIView = {
        let divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .white
        return divider
    }()
    
    // MARK: - Init
     init(frame: CGRect, viewModel: WorkoutViewModel) {
         self.viewModel = viewModel
         super.init(frame: frame)
         translatesAutoresizingMaskIntoConstraints = false
         container.addSubviews(rating, ratingLabel, divider,
                               startTimeLabel, startTimePicker, dividerStartTime
         )
         
         guard let startTime = self.viewModel.workout.startTime else {
             fatalError()
         }
         self.startTimePicker.setDate(startTime, animated: false)
         
         addSubviews(topBar, container)
         addSubview(rating)
         self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initializer")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            topBar.centerXAnchor.constraint(equalTo: centerXAnchor),
            topBar.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.95),
            topBar.heightAnchor.constraint(equalToConstant: 30),

            container.topAnchor.constraint(equalTo: topBar.bottomAnchor),
            container.widthAnchor.constraint(equalTo: topBar.widthAnchor),
            container.centerXAnchor.constraint(equalTo: centerXAnchor),
            container.heightAnchor.constraint(equalToConstant: 170),

            ratingLabel.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: 10),
            ratingLabel.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 30),

            rating.centerYAnchor.constraint(equalTo: ratingLabel.centerYAnchor),
            rating.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -30),

            divider.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.9),
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 8),
            divider.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            startTimeLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 10),
            startTimeLabel.leftAnchor.constraint(equalTo: ratingLabel.leftAnchor),
            
            startTimePicker.centerYAnchor.constraint(equalTo: startTimeLabel.centerYAnchor),
            startTimePicker.rightAnchor.constraint(equalTo: rating.rightAnchor),
            
            dividerStartTime.widthAnchor.constraint(equalTo: divider.widthAnchor),
            dividerStartTime.heightAnchor.constraint(equalTo: divider.heightAnchor),
            dividerStartTime.centerXAnchor.constraint(equalTo: centerXAnchor),
            dividerStartTime.topAnchor.constraint(equalTo: startTimeLabel.bottomAnchor, constant: 8)
        ])
    }

}

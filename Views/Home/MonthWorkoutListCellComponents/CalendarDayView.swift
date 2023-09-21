//
//  CalendarDayContainer.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/26/23.
//

import UIKit

final class CalendarDayView: UIView {
    
    // Top bar of the calendar
    private let topCalendarBar: UIView = {
        let topCalendarBar = UIView()
        topCalendarBar.translatesAutoresizingMaskIntoConstraints = false
        topCalendarBar.backgroundColor = .systemGray4
        topCalendarBar.layer.cornerRadius = 10
        topCalendarBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return topCalendarBar
    }()
    
    // Container for the calendar day
    private let bottomCalendarView: UIView = {
        let bottomCalendarView = UIView()
        bottomCalendarView.translatesAutoresizingMaskIntoConstraints = false
        bottomCalendarView.backgroundColor = .systemGray.withAlphaComponent(0.44)
        bottomCalendarView.layer.cornerRadius = 10
        bottomCalendarView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return bottomCalendarView
    }()
    
    // Label for the day of the month
    public let calendarLabel: UILabel = {
        let calendarLabel = UILabel()
        calendarLabel.textColor = .label
        calendarLabel.font = .systemFont(ofSize: 14, weight: .bold)
        calendarLabel.translatesAutoresizingMaskIntoConstraints = false
        return calendarLabel
    }()

    // Creates calendar circles
    private func calendarCircle() -> UIView {
        let calendarCircle = UIView()
        calendarCircle.translatesAutoresizingMaskIntoConstraints = false
        calendarCircle.layer.cornerRadius = 2
        calendarCircle.layer.masksToBounds = true
        calendarCircle.backgroundColor = .white
        calendarCircle.layer.borderWidth = 1
        calendarCircle.layer.borderColor = UIColor.systemGray.cgColor
        return calendarCircle
    }
    lazy var leftCircle: UIView = calendarCircle()
    lazy var rightCircle: UIView = calendarCircle()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubviews(self.topCalendarBar, self.bottomCalendarView, self.leftCircle, self.rightCircle, self.calendarLabel)
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.topCalendarBar.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.topCalendarBar.heightAnchor.constraint(equalToConstant: 8),
            self.topCalendarBar.topAnchor.constraint(equalTo: self.topAnchor),
            self.topCalendarBar.widthAnchor.constraint(equalToConstant: 32),
            
            self.bottomCalendarView.centerXAnchor.constraint(equalTo: self.topCalendarBar.centerXAnchor),
            self.bottomCalendarView.topAnchor.constraint(equalTo: self.topCalendarBar.bottomAnchor),
            self.bottomCalendarView.heightAnchor.constraint(equalToConstant: 22),
            self.bottomCalendarView.widthAnchor.constraint(equalToConstant: 30),
            
            self.calendarLabel.centerXAnchor.constraint(equalTo: self.bottomCalendarView.centerXAnchor),
            self.calendarLabel.centerYAnchor.constraint(equalTo: self.bottomCalendarView.centerYAnchor),
            
            self.leftCircle.heightAnchor.constraint(equalToConstant: 4),
            self.leftCircle.widthAnchor.constraint(equalToConstant: 4),
            self.leftCircle.centerXAnchor.constraint(equalTo: self.topCalendarBar.centerXAnchor, constant: -6),
            self.leftCircle.centerYAnchor.constraint(equalTo: self.topCalendarBar.centerYAnchor),
            
            self.rightCircle.heightAnchor.constraint(equalToConstant: 4),
            self.rightCircle.widthAnchor.constraint(equalToConstant: 4),
            self.rightCircle.centerXAnchor.constraint(equalTo: self.topCalendarBar.centerXAnchor, constant: 6),
            self.rightCircle.centerYAnchor.constraint(equalTo: self.topCalendarBar.centerYAnchor)
        ])
        
    }
}

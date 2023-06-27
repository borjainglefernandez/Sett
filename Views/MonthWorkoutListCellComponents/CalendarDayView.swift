//
//  CalendarDayContainer.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/26/23.
//

import UIKit

final class CalendarDayView: UIView {
    
    public var day: String? {
        didSet {
            self.calendarLabel.text = self.day
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(self.topCalendarView, self.bottomCalendarView, self.leftCircle, self.rightCircle, self.calendarLabel)
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initializer")
    }
    
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
    
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            self.topCalendarView.leftAnchor.constraint(equalTo: leftAnchor),
            self.topCalendarView.heightAnchor.constraint(equalToConstant: 8),
            self.topCalendarView.topAnchor.constraint(equalTo: topAnchor),
            self.topCalendarView.widthAnchor.constraint(equalToConstant: 32),
            
            self.bottomCalendarView.centerXAnchor.constraint(equalTo: topCalendarView.centerXAnchor),
            self.bottomCalendarView.topAnchor.constraint(equalTo: topCalendarView.bottomAnchor),
            self.bottomCalendarView.heightAnchor.constraint(equalToConstant: 22),
            self.bottomCalendarView.widthAnchor.constraint(equalToConstant: 30),
            
            self.calendarLabel.centerXAnchor.constraint(equalTo: bottomCalendarView.centerXAnchor),
            self.calendarLabel.centerYAnchor.constraint(equalTo: bottomCalendarView.centerYAnchor),
            
            self.leftCircle.heightAnchor.constraint(equalToConstant: 4),
            self.leftCircle.widthAnchor.constraint(equalToConstant: 4),
            self.leftCircle.centerXAnchor.constraint(equalTo: topCalendarView.centerXAnchor, constant: -6),
            self.leftCircle.centerYAnchor.constraint(equalTo: topCalendarView.centerYAnchor),
            
            self.rightCircle.heightAnchor.constraint(equalToConstant: 4),
            self.rightCircle.widthAnchor.constraint(equalToConstant: 4),
            self.rightCircle.centerXAnchor.constraint(equalTo: topCalendarView.centerXAnchor, constant: 6),
            self.rightCircle.centerYAnchor.constraint(equalTo: topCalendarView.centerYAnchor),
            
        ])
        
    }
}

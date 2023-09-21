//
//  DayOfTheWeekPickerContainer.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 9/9/23.
//

import UIKit

class DayOfTheWeekPickerContainer: UIView {
    
    private let routine: Routine
    
    // Top bar
    private let topBar: MenuBar = MenuBar(maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    
    // Content container
    private let contentContainer: UIView = {
        let contentContainer = UIView()
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.backgroundColor = .systemGray3.withAlphaComponent(0.44)
        contentContainer.layer.cornerRadius = 15
        contentContainer.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return contentContainer
    }()
    
    // Title label for container
    private let titleLabel: Label = Label(title: "Days to Train", fontSize: 14.0)
    
    // List of the each day of the week picker
    lazy var daysOfTheWeekPickers: [DayOfTheWeekPicker] = {
        var daysOfTheWeekPickers: [DayOfTheWeekPicker] = []
        
        for dayOfTheWeek in DayOfTheWeek.allCases {
            let dayOfTheWeekPickerVM = DayOfTheWeekPickerVM(routine: self.routine, dayOfTheWeek: dayOfTheWeek)
            let dayOfTheWeekPicker = DayOfTheWeekPicker(viewModel: dayOfTheWeekPickerVM)
            daysOfTheWeekPickers.append(dayOfTheWeekPicker)
        }
        
        return daysOfTheWeekPickers
    }()

    // MARK: - Init
    init(frame: CGRect = .zero, routine: Routine) {
        self.routine = routine
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        self.contentContainer.addSubviews(self.titleLabel)
        for daysOfTheWeekPicker in daysOfTheWeekPickers {
            self.contentContainer.addSubview(daysOfTheWeekPicker)
        }
        addSubviews(self.topBar, self.contentContainer)
        
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 65),
            
            self.topBar.topAnchor.constraint(equalTo: self.topAnchor),
            self.topBar.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.topBar.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            self.contentContainer.topAnchor.constraint(equalTo: self.topBar.bottomAnchor),
            self.contentContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.contentContainer.widthAnchor.constraint(equalTo: self.topBar.widthAnchor),
            self.contentContainer.heightAnchor.constraint(equalToConstant: 35),
            
            self.titleLabel.leftAnchor.constraint(equalTo: self.contentContainer.leftAnchor, constant: 25),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.contentContainer.centerYAnchor, constant: -2),
            
            self.daysOfTheWeekPickers[0].leftAnchor.constraint(equalTo: self.titleLabel.rightAnchor, constant: 10),
            self.daysOfTheWeekPickers[0].centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor)
        ])
        
        for i in 1..<self.daysOfTheWeekPickers.count {
            let previousDayOfTheWeekPicker: DayOfTheWeekPicker = self.daysOfTheWeekPickers[i - 1]
            let currentDayOfTheWeekPicker: DayOfTheWeekPicker = self.daysOfTheWeekPickers[i]
            NSLayoutConstraint.activate([
                currentDayOfTheWeekPicker.leftAnchor.constraint(equalTo: previousDayOfTheWeekPicker.rightAnchor, constant: 10),
                currentDayOfTheWeekPicker.centerYAnchor.constraint(equalTo: previousDayOfTheWeekPicker.centerYAnchor)
                
            ])
            
        }
    }

}

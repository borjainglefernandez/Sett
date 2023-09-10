//
//  DayOfTheWeekPicker.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 9/9/23.
//

import UIKit

class DayOfTheWeekPicker: UIView {
    
    private let viewModel: DayOfTheWeekPickerVM
    
    // Container will be cyan if selected, gray otherwise
    private let containerColors: Dictionary<Bool, UIColor> = [
        true: .systemCyan,
        false: .systemGray4
    ]
    
    // Container
    lazy var container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = 5
        return container
    }()
    
    // Label for day of the week
    lazy var label: Label = Label(title: String(self.viewModel.dayOfTheWeek.rawValue.first!), fontSize: 14.0)
    
    // MARK: - Init
    init(frame: CGRect = .zero, viewModel: DayOfTheWeekPickerVM) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false

        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectDeselect)))
        
        self.choooseBackgroundColor()
        self.container.addSubviews(self.label)
        self.addSubviews(self.container)
        
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 20),
            self.heightAnchor.constraint(equalToConstant: 20),
            
            self.container.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.container.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.container.topAnchor.constraint(equalTo: self.topAnchor),
            self.container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.label.centerYAnchor.constraint(equalTo: self.container.centerYAnchor),
            self.label.centerXAnchor.constraint(equalTo: self.container.centerXAnchor)
        ])
    }
    
    // MARK: - Actions
    @objc func selectDeselect() {
        self.viewModel.selectDeselect()
        self.choooseBackgroundColor()
    }
    
    private func choooseBackgroundColor() {
        self.container.backgroundColor = self.containerColors[self.viewModel.selected]
    }

}

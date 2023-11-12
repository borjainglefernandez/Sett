//
//  NumberLabelView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 11/10/23.
//

import UIKit

class NumberLabelView: UIView {
    // Instance Variables
    private let title: String
    private let titleFontSize: Double
    private let numberFontSize: Double
    
    // Title Label
    lazy var titleLabel: Label = Label(title: self.title, fontSize: self.titleFontSize, weight: .light)
    
    // Number Label
    lazy var numberLabel: Label = Label(title: "0", fontSize: self.numberFontSize, weight: .bold)
    
    // MARK: - Init
    init(frame: CGRect = .zero, title: String, titleFontSize: Double = 11, numberFontSize: Double = 12) {
        self.title = title
        self.titleFontSize = titleFontSize
        self.numberFontSize = numberFontSize
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubviews(self.titleLabel, self.numberLabel)
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.numberLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            self.numberLabel.centerXAnchor.constraint(equalTo: self.titleLabel.centerXAnchor)
        ])
    }
    
    // MARK: - Setter
    public func setNumberText(text: String) {
        self.numberLabel.text = text
    }
}

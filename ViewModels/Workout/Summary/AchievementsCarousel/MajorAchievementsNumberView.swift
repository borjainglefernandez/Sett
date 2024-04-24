//
//  MajorAchievementsNumberView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/24/24.
//

import UIKit

class MajorAchievementsNumberView: UIView {
    
    // Outer circular container
    private let outerAchievementsNumberContainer: UIView = {
        let achievementsNumberContainer =  UIView()
        achievementsNumberContainer.translatesAutoresizingMaskIntoConstraints = false
        achievementsNumberContainer.layer.cornerRadius = 25 / 2
        achievementsNumberContainer.layer.borderWidth = 10
        achievementsNumberContainer.layer.borderColor = UIColor.systemGray6.cgColor
        achievementsNumberContainer.backgroundColor = .label
        return achievementsNumberContainer
    }()
    
    // Second circular container
    private let innerAchievementsNumberContainer: UIView = {
        let achievementsNumberContainer =  UIView()
        achievementsNumberContainer.translatesAutoresizingMaskIntoConstraints = false
        achievementsNumberContainer.layer.cornerRadius = 25 / 2
        achievementsNumberContainer.backgroundColor = .systemCyan
        return achievementsNumberContainer
    }()
    
    //

    // MARK: - Init
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
}

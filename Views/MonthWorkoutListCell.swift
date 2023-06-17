//
//  MonthWorkoutListCell.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/17/23.
//

import UIKit

final class MonthWorkoutListCell: UICollectionViewCell {
    static let cellIdentifier = "MonthWorkoutListCell"
    
    private let toggleArrowButton: UIButton = {
        let iconButton = UIButton(type: .custom)
        let iconImage = UIImage(named: "chevron.right") // Replace "iconImage" with the name of your icon image asset
        
        // Set the icon image for the normal state
        iconButton.setImage(iconImage, for: .normal)
        return iconButton
    }()
    
    private let topBar: UIView = {
        
        let topBar = UIView()
        let iconButton = UIButton(type: .custom)
        let iconImage = UIImage(named: "chevron.right") // Replace "iconImage" with the name of your icon image asset
        
        // Set the icon image for the normal state
        iconButton.setImage(iconImage, for: .normal)
        topBar.addSubview(iconButton)

        topBar.clipsToBounds = true
        topBar.layer.cornerRadius = 15
        topBar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]

        topBar.backgroundColor = .systemGray4
        topBar.translatesAutoresizingMaskIntoConstraints = false
        
        return topBar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray3
        contentView.layer.cornerRadius = 15
        addSubviews(topBar)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported constructor")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: topAnchor),
            topBar.leftAnchor.constraint(equalTo: leftAnchor),
            topBar.rightAnchor.constraint(equalTo: rightAnchor),
            topBar.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25)
        ])
    }
    
    public func configureWith(with viewModel: MonthWorkoutListCellViewModel) {
        
    }
    
    
}

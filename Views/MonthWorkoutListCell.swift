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
        let iconImage = UIImage(systemName: "chevron.right")
        var config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 17.0, weight: .bold))
        iconButton.tintColor = .white
        iconButton.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        iconButton.setImage(iconImage, for: .normal)
        iconButton.translatesAutoresizingMaskIntoConstraints = false
        return iconButton
    }()
    
    private let monthWorkoutListView = MonthWorkoutListView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray4
        contentView.layer.cornerRadius = 15
        addSubview(toggleArrowButton)
        addSubview(monthWorkoutListView)
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
            toggleArrowButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            monthWorkoutListView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9),
            monthWorkoutListView.bottomAnchor.constraint(equalTo: bottomAnchor),
            monthWorkoutListView.rightAnchor.constraint(equalTo: rightAnchor),
            monthWorkoutListView.leftAnchor.constraint(equalTo: leftAnchor),
        ])
    }
    
    public func configureWith(with viewModel: MonthWorkoutListCellViewModel) {
        
    }
    
    
}

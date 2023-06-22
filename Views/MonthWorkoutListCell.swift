//
//  MonthWorkoutTableViewCell.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/22/23.
//

import UIKit

class MonthWorkoutListCell: UITableViewCell {
    static let cellIdentifier = "MonthWorkoutTableViewCell"
    
    private let cellLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        contentView.backgroundColor = .systemGray2.withAlphaComponent(0.6)
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 15
        contentView.addSubview(cellLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initializer")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellLabel.text = nil
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            cellLabel.leftAnchor.constraint(equalToSystemSpacingAfter: leftAnchor, multiplier: 2),
            cellLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
        ])
    }
    
    public func configure(with viewModel: MonthWorkoutListCellViewModel) {
        cellLabel.text = "\(String(describing: viewModel.workout.startTime))"
    }
}

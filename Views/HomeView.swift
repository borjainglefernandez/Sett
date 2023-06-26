//
//  WorkoutListView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/16/23.
//

import UIKit

class HomeView: UIView {
    private let viewModel = HomeViewModel()
    
    private let topBar: UIView = {
        let topBar = UIView()
        topBar.translatesAutoresizingMaskIntoConstraints = false
        topBar.backgroundColor = .systemGray4
        topBar.layer.cornerRadius = 15
        return topBar
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.text = "Workouts"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addWorkoutButton: UIButton = {
        let iconButton = UIButton(type: .custom)
        let iconImage = UIImage(systemName: "plus.circle")
        var config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 17.0, weight: .bold))
        iconButton.tintColor = .systemCyan
        iconButton.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        iconButton.translatesAutoresizingMaskIntoConstraints = false
        iconButton.setImage(iconImage, for: .normal)
        return iconButton
    }()
    
    private let sortWorkoutButton: UIButton = {
        let iconButton = UIButton(type: .custom)
        let iconImage = UIImage(systemName: "arrow.up.arrow.down.circle")
        var config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 17.0, weight: .bold))
        iconButton.tintColor = .systemCyan
        iconButton.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        iconButton.translatesAutoresizingMaskIntoConstraints = false
        iconButton.setImage(iconImage, for: .normal)
        return iconButton
    }()
    
    public let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MonthListCell.self, forCellWithReuseIdentifier: MonthListCell.cellIdentifier)
        collectionView.backgroundColor = .systemCyan
        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        topBar.addSubviews(titleLabel, addWorkoutButton, sortWorkoutButton)
        addSubviews(topBar, collectionView)
        addConstraints()
        viewModel.configure()
        setUpCollectionView()
    }
    required init?(coder: NSCoder) {
        fatalError("Unsupported initializer")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: topBar.leftAnchor, multiplier: 2),
            titleLabel.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            sortWorkoutButton.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            sortWorkoutButton.rightAnchor.constraint(equalTo: topBar.rightAnchor, constant: -15),
            addWorkoutButton.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            addWorkoutButton.rightAnchor.constraint(equalTo: sortWorkoutButton.leftAnchor, constant: -7),
            topBar.topAnchor.constraint(equalTo: topAnchor),
            topBar.centerXAnchor.constraint(equalTo: centerXAnchor),
            topBar.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.95),
            topBar.heightAnchor.constraint(equalToConstant: 30),
            collectionView.topAnchor.constraint(equalTo: topBar.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setUpCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel

    }
}

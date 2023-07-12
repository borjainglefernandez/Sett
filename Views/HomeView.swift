//
//  HomeView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/16/23.
//

import UIKit

protocol WorkoutsDelegate: NSObjectProtocol {
    func addWorkout(collectionView: UICollectionView)
}


final class HomeView: UIView {
    weak var delegate:WorkoutsDelegate?
    
    let viewModel = HomeViewModel()
    
    // Top bar of the home page
    private let topBar: UIView = {
        let topBar = UIView()
        topBar.translatesAutoresizingMaskIntoConstraints = false
        topBar.backgroundColor = .systemGray4
        topBar.layer.cornerRadius = 15
        return topBar
    }()
    
    // Title label for currently selected feed
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        
        titleLabel.textColor = .label
        titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
        titleLabel.text = "Workouts"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    // Button to add a workout
    private let addWorkoutButton: UIButton = {
        let addWorkoutButton = UIButton(type: .custom)
        let iconImage = UIImage(systemName: "plus.circle")
        var config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 17.0, weight: .bold))
        addWorkoutButton.tintColor = .systemCyan
        addWorkoutButton.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        addWorkoutButton.translatesAutoresizingMaskIntoConstraints = false
        addWorkoutButton.setImage(iconImage, for: .normal)
        addWorkoutButton.showsMenuAsPrimaryAction = true
        return addWorkoutButton
    }()
    
    // Button to sort workouts
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
    
    // View for when there are no workouts to display
    public let emptyView: UILabel = {
        let emptyView = UILabel()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.textColor = .label
        emptyView.font = .systemFont(ofSize: 17.0, weight: .bold)
        emptyView.text = "No Workouts Completed Yet!"
        emptyView.textAlignment = .center
        emptyView.isHidden = true
        return emptyView
    }()
    
    // Collection view of the month workout containers
    public let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MonthListCell.self, forCellWithReuseIdentifier: MonthListCell.cellIdentifier)
        collectionView.backgroundColor = .systemCyan
        collectionView.isHidden = true
        return collectionView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        topBar.addSubviews(titleLabel, addWorkoutButton, sortWorkoutButton, emptyView)
        addSubviews(topBar, collectionView)
        addConstraints()
        viewModel.configure()
        setUpAddWorkoutMenu()
        setUpDelegate()
        setUpCollectionView()
        showHideCollectionView()
    }
    required init?(coder: NSCoder) {
        fatalError("Unsupported initializer")
    }
    
    // MARK: - Constraints
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
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            emptyView.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    // MARK: - Configurations
    private func setUpAddWorkoutMenu() {
        let blankWorkoutButton = UIAction(title: "Blank Workout", image: UIImage(systemName: "plus.circle"), attributes: [], state: .off) { action in
            self.addWorkout()
        }
        let startWorkoutButton = UIAction(title: "Start Routine", image: UIImage(systemName: "arrow.clockwise.circle"), attributes: [], state: .off) { action in
            self.startRoutine()
        }
        
        self.addWorkoutButton.menu = UIMenu(children: [blankWorkoutButton, startWorkoutButton])
    }
    
    private func setUpDelegate() {
        delegate = viewModel
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
    
    private func showHideCollectionView() {
        if viewModel.getWorkoutsLength() > 0 {
            collectionView.isHidden = false
            emptyView.isHidden = true
        } else {
            collectionView.isHidden = true
            emptyView.isHidden = false
        }
    }
    
    // MARK: - Actions
    private func addWorkout() {
        if let delegate = self.delegate {
            delegate.addWorkout(collectionView: self.collectionView)
        }
        
        // Show collection view if previously hidden
        showHideCollectionView()
    }
    
    private func startRoutine() {
        print("f")
    }
}

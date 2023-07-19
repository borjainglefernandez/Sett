//
//  HomeView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/16/23.
//

import UIKit

protocol WorkoutsDelegate: NSObjectProtocol {
    /// Add Workout
    ///
    /// - Parameter collectionView: The collection view to update after adding workout
    func addWorkout(collectionView: UICollectionView)
}


final class HomeView: UIView {
    
    let viewModel = HomeViewModel()
    
    // Delegate to call to add workout
    weak var delegate: WorkoutsDelegate?
    
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
        
        self.backgroundColor = .systemCyan
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.viewModel.configure()
        self.setUpDelegate()
        self.setUpCollectionView()
        self.showHideCollectionView()
        
        self.addSubviews(collectionView, emptyView)
        self.addConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("Unsupported initializer")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.emptyView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.emptyView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    // MARK: - Configurations
    private func setUpDelegate() {
        self.delegate = self.viewModel
    }
    
    private func setUpCollectionView() {
        self.collectionView.dataSource = self.viewModel
        self.collectionView.delegate = self.viewModel
        self.viewModel.homeView = self
    }
    
    // Shows or hides collection view depending on whether or not there are workouts
    public func showHideCollectionView() {
        if self.viewModel.getWorkoutsLength() > 0 {
            self.collectionView.isHidden = false
            self.emptyView.isHidden = true
        } else {
            self.collectionView.isHidden = true
            self.emptyView.isHidden = false
        }
    }
}

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
        backgroundColor = .systemCyan
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(collectionView, emptyView)
        addConstraints()
        viewModel.configure()
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
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            emptyView.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    // MARK: - Configurations
    private func setUpDelegate() {
        delegate = viewModel
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
        viewModel.collection = self.collectionView
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
}

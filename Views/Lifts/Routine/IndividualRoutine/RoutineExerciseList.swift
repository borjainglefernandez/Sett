//
//  RoutineExerciseList.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/28/23.
//

import UIKit

class RoutineExerciseList: UIView {

    public let viewModel: RoutineExerciseListVM
    
    // Day of the week selector
    lazy var dayOfTheWeekPickerContainer: DayOfTheWeekPickerContainer = DayOfTheWeekPickerContainer(routine: self.viewModel.routine)
    
    // Collection view of the category exercise containers
    public let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RoutineExerciseListCell.self, forCellWithReuseIdentifier: RoutineExerciseListCell.cellIdentifier)
        collectionView.backgroundColor = .systemCyan
        return collectionView
    }()
    
    // Add exercise bottom bar
    lazy var addExerciseBottomBar: AddExerciseBottomBar = AddExerciseBottomBar(maskCorners: false, addExerciseCallBack: self.addExercise)

    // MARK: - Init
    init(frame: CGRect = .zero, viewModel: RoutineExerciseListVM) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        self.backgroundColor = .systemCyan
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = true
        
        self.viewModel.configure()
        self.setUpCollectionView()
        
        self.addSubviews(self.dayOfTheWeekPickerContainer, self.collectionView, self.addExerciseBottomBar)
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.dayOfTheWeekPickerContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.dayOfTheWeekPickerContainer.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.95),
            self.dayOfTheWeekPickerContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.collectionView.topAnchor.constraint(equalTo: self.dayOfTheWeekPickerContainer.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -60),
            
            self.addExerciseBottomBar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.addExerciseBottomBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.95),
            self.addExerciseBottomBar.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor),
            self.addExerciseBottomBar.heightAnchor.constraint(equalToConstant: 30)
            
        ])
    }
    
    // MARK: - Configurations
    private func setUpCollectionView() {
        self.collectionView.dataSource = self.viewModel
        self.collectionView.delegate = self.viewModel
        self.viewModel.routineExerciseList = self
    }
    
    // MARK: - Actions
    public func addExercise() {
        if let parentViewController = self.getParentViewController(self) {
            let selectCategoryModalViewController = SelectCategoryModalViewController(routine: self.viewModel.routine)
            parentViewController.present(selectCategoryModalViewController, animated: true)
        }
    }
}

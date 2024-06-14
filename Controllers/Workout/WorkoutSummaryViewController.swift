//
//  WorkoutSummaryViewController.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/24/24.
//

import UIKit

class WorkoutSummaryViewController: UIViewController {
    
    public let workout: Workout
    
    private let topBar: MenuBar = MenuBar(frame: .zero)
    private let backButton: UIButton = IconButton(frame: .zero, imageName: "arrow.backward.circle.fill")
    private let confirmButton: UIButton = IconButton(frame: .zero, imageName: "checkmark.circle.fill")
    
    private let generalStatsVM: WorkoutGeneralStatsVM
    
    private let achievementsCarouselView: AchievementsCarouselView

    lazy var workoutName: UITextField = {
        let workoutName = UITextField()
        workoutName.textColor = .label
        workoutName.font = .systemFont(ofSize: 17, weight: .bold)
        workoutName.translatesAutoresizingMaskIntoConstraints = false
        workoutName.text = self.generalStatsVM.workout.title
        workoutName.delegate = self.generalStatsVM
        return workoutName
    }()
    
    // Pagination Dots
    lazy var paginationDots: UIPageControl = {
        let paginationDots = UIPageControl()
        paginationDots.translatesAutoresizingMaskIntoConstraints = false
        paginationDots.currentPageIndicatorTintColor = .label
        paginationDots.pageIndicatorTintColor = .black
        paginationDots.currentPage = 0
        paginationDots.numberOfPages = self.generalStatsVM.workout.achievementsCount
        return paginationDots
      }()
    
    // MARK: - Init
    init(workout: Workout) {
        self.workout = workout
        let cellVMs = WorkoutGeneralStatsViewType.getGeneralStatsWorkoutComponents().compactMap { type in
            return WorkoutGeneralStatsViewCellVM(type: type, workout: workout)
        }
        self.generalStatsVM = WorkoutGeneralStatsVM(workout: workout, cellVMs: cellVMs)
        self.achievementsCarouselView = AchievementsCarouselView(viewModel: AchievementsCarouselVM(workout: workout))

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dismissKeyboardWhenTapOutside()
        
        self.view.backgroundColor = .systemCyan
        
        self.topBar.addSubviews(self.backButton, self.workoutName, self.confirmButton)
        self.view.addSubviews(self.topBar, self.achievementsCarouselView, self.paginationDots)
        self.addConstraints()
        
        self.backButton.addTarget(self, action: #selector(self.goBack), for: .touchUpInside)
        self.confirmButton.addTarget(self, action: #selector(self.confirm), for: .touchUpInside)
        
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.topBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.topBar.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.topBar.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.95),
            
            self.backButton.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            self.backButton.leftAnchor.constraint(equalTo: self.topBar.leftAnchor, constant: 7),
            
            self.workoutName.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            self.workoutName.centerXAnchor.constraint(equalTo: self.topBar.centerXAnchor),
            
            self.confirmButton.centerYAnchor.constraint(equalTo: self.topBar.centerYAnchor),
            self.confirmButton.rightAnchor.constraint(equalTo: self.topBar.rightAnchor, constant: -7),
            
            self.achievementsCarouselView.topAnchor.constraint(equalTo: self.topBar.bottomAnchor, constant: 7),
            self.achievementsCarouselView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.achievementsCarouselView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            self.achievementsCarouselView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.38),
            
            self.paginationDots.topAnchor.constraint(equalTo: self.achievementsCarouselView.bottomAnchor),
            self.paginationDots.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            
        ])
    }
    
    // MARK: - Actions
    @objc func goBack() {
        self.dismiss(animated: true)
    }
    
    @objc func confirm() {
        self.dismiss(animated: true)
    }
    
    public func changePagination(currentPage: Int) {
        self.paginationDots.currentPage = currentPage
    }
}

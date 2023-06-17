//
//  HomeViewController.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/7/23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let workoutListView = WorkoutListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        view.addSubview(workoutListView)
        NSLayoutConstraint.activate([
            workoutListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            workoutListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            workoutListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            workoutListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}


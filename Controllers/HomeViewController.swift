//
//  HomeViewController.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/7/23.
//

import UIKit

final class HomeViewController: UIViewController {

    private let monthListView = MonthListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        view.addSubview(monthListView)
        NSLayoutConstraint.activate([
            monthListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            monthListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            monthListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            monthListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}


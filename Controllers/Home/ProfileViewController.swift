//
//  ProfileViewController.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/7/23.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private let signOutButton: UIButton = {
        let signOutButton = UIButton(type: .roundedRect)
        signOutButton.frame = CGRect(x: 0, y: 0, width: 250, height: 50)
        signOutButton.backgroundColor = .red
        signOutButton.setTitle("Sign Out", for: .normal)
        return signOutButton
    }()
    
    private let wipeWorkoutsButton: UIButton = {
        let wipeWorkoutsButton = UIButton(type: .roundedRect)
        wipeWorkoutsButton.frame = CGRect(x: 0, y: 0, width: 250, height: 50)
        wipeWorkoutsButton.backgroundColor = .red
        wipeWorkoutsButton.setTitle("Wipe Workouts", for: .normal)
        wipeWorkoutsButton.translatesAutoresizingMaskIntoConstraints = false
        return wipeWorkoutsButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        setUpSignOutButton()
        setUpWipeWorkoutsButton()
    }
    
    private func setUpSignOutButton() {
        signOutButton.center = view.center
        signOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        view.addSubview(signOutButton)
    }
    
    private func setUpWipeWorkoutsButton() {
        view.addSubview(wipeWorkoutsButton)
        NSLayoutConstraint.activate([
            wipeWorkoutsButton.topAnchor.constraint(equalTo: signOutButton.bottomAnchor),
            wipeWorkoutsButton.widthAnchor.constraint(equalTo: signOutButton.widthAnchor),
            wipeWorkoutsButton.heightAnchor.constraint(equalTo: signOutButton.heightAnchor),
            wipeWorkoutsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        wipeWorkoutsButton.addTarget(self, action: #selector(wipeOutWorkouts), for: .touchUpInside)
    }
    
    @objc func signOut() {
        KeychainItem.deleteUserIdentifierFromKeychain()
        view.navigateToScreenFromTabBar(self.tabBarController, LoginController())
    }
    
    @objc func wipeOutWorkouts() {
        let workouts = CoreDataBase.fetchEntities(withEntity: "Workout", expecting: Workout.self)
        if let workouts = workouts {
            for workout in workouts {
                CoreDataBase.context.delete(workout)
                
            }
        }
        CoreDataBase.save()
    }
}

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
    
    private let wipeStuffButton: UIButton = {
        let wipeStuffButton = UIButton(type: .roundedRect)
        wipeStuffButton.frame = CGRect(x: 0, y: 0, width: 250, height: 50)
        wipeStuffButton.backgroundColor = .red
        wipeStuffButton.setTitle("Wipe Stuff", for: .normal)
        wipeStuffButton.translatesAutoresizingMaskIntoConstraints = false
        return wipeStuffButton
    }()
    
    private let createStaticDataButton: UIButton = {
        let createStaticDataButton = UIButton(type: .roundedRect)
        createStaticDataButton.frame = CGRect(x: 0, y: 0, width: 250, height: 50)
        createStaticDataButton.backgroundColor = .green
        createStaticDataButton.setTitle("Load Exercises", for: .normal)
        createStaticDataButton.translatesAutoresizingMaskIntoConstraints = false
        return createStaticDataButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        setUpSignOutButton()
        setUpWipeStuffButton()
        setUpCreateStaticDataButton()
    }
    
    private func setUpSignOutButton() {
        signOutButton.center = view.center
        signOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        view.addSubview(signOutButton)
    }
    
    private func setUpWipeStuffButton() {
        view.addSubview(wipeStuffButton)
        NSLayoutConstraint.activate([
            wipeStuffButton.topAnchor.constraint(equalTo: signOutButton.bottomAnchor),
            wipeStuffButton.widthAnchor.constraint(equalTo: signOutButton.widthAnchor),
            wipeStuffButton.heightAnchor.constraint(equalTo: signOutButton.heightAnchor),
            wipeStuffButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        wipeStuffButton.addTarget(self, action: #selector(wipeStuff), for: .touchUpInside)
    }
    
    private func setUpCreateStaticDataButton() {
        view.addSubview(createStaticDataButton)
        NSLayoutConstraint.activate([
            createStaticDataButton.topAnchor.constraint(equalTo: wipeStuffButton.bottomAnchor),
            createStaticDataButton.widthAnchor.constraint(equalTo: wipeStuffButton.widthAnchor),
            createStaticDataButton.heightAnchor.constraint(equalTo: wipeStuffButton.heightAnchor),
            createStaticDataButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        createStaticDataButton.addTarget(self, action: #selector(createStaticData), for: .touchUpInside)
    }
    
    @objc func signOut() {
        KeychainItem.deleteUserIdentifierFromKeychain()
        view.navigateToScreenFromTabBar(self.tabBarController, LoginController())
    }
    
    @objc func wipeStuff() {
        let entityNames = ["WorkoutExercise", "Routine", "Exercise", "Category"]
        let entityTypes = [WorkoutExercise.self, Routine.self, Exercise.self, Category.self]
        
        for i in 0 ..< entityNames.count  {
            let entities = CoreDataBase.fetchEntities(withEntity: entityNames[i], expecting: entityTypes[i])
            if let entities = entities {
                for entity in entities {
                    CoreDataBase.context.delete(entity)
                    
                }
            }
            CoreDataBase.save()
        }
    }
    
    @objc func createStaticData() {
        StaticDataCreator.createStaticData()
    }
}

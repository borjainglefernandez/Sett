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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        setUpSignOutButton()
    }
    
    private func setUpSignOutButton() {
        signOutButton.center = view.center
        signOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        view.addSubview(signOutButton)
    }
    
    @objc func signOut() {
        KeychainItem.deleteUserIdentifierFromKeychain()
        view.navigateToScreenFromTabBar(self.tabBarController, LoginController())
    }
}

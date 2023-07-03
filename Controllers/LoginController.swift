//
//  LoginController.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/6/23.
//

import AuthenticationServices
import UIKit

// TODO: Move UI Stuff to a UIView and ViewModel

final class LoginController: UIViewController {
    
    // Sign in with apple button
    private let signInButton = ASAuthorizationAppleIDButton()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        
        signInButton.addTarget(self, action: #selector(didTapAppleSignIn), for: .touchUpInside)
        view.addSubview(signInButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.frame = CGRect(x: 0, y: 0, width: 250, height: 50)
        signInButton.center = view.center
    }
    
    // MARK: - Actions
    
    /// Sign in a user
    @objc func didTapAppleSignIn() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.email, .fullName]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
        
    }
    
    private func saveUserInKeychain(_ userIdentifier: String) {
        do {
            try KeychainItem(service: "com.example.apple-samplecode.juice", account: "userIdentifier").saveItem(userIdentifier)
        } catch {
            print("Unable to save userIdentifier to keychain.")
        }
    }
}

extension LoginController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("failed!")
    }
    
    /// Authorizes a user and navigates them to the tab bar view
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            self.saveUserInKeychain(userIdentifier)
            let tabViewController = TabViewController()
            view.navigateToScreen(self.navigationController, tabViewController)
        }
    }
}

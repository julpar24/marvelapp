//
//  LoginViewController.swift
//  marvelapp
//
//  Created by Juliana Pardal on 29/08/2021.
//

import UIKit
import FirebaseAuthUI
import FirebaseEmailAuthUI

class LoginViewController: UIViewController, FUIAuthDelegate {
    // MARK: - Variables and constants
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            guard let user = user else {
                self?.showLoginVC()
                return
            }
            self?.goToAppHome(user: user)
        }
        
    }
    
    func goToAppHome(user: User? = nil) {
        let homeVC = ViewControllerFactory.homeViewController()
        homeVC.modalPresentationStyle = .overCurrentContext
        present(homeVC, animated: true, completion: nil)
    }
    
    func showLoginVC() {
        let authUI = FUIAuth.defaultAuthUI()
        let providers = [FUIEmailAuth()]
        authUI?.providers = providers
        authUI?.delegate = self
        guard let authViewController = authUI?.authViewController() else { return }
        authViewController.modalPresentationStyle = .overCurrentContext
        present(authViewController, animated: true, completion: nil)
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        goToAppHome(user: user)
    }
}

extension FUIAuthBaseViewController{
    open override func viewWillAppear(_ animated: Bool) {
        navigationItem.leftBarButtonItem = nil
    }
}


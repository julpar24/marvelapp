//
//  ViewController.swift
//  marvelapp
//
//  Created by Juliana Pardal on 29/08/2021.
//

import UIKit
import FirebaseAuthUI
import FirebaseEmailAuthUI

class ViewController: UIViewController {
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
            self?.showUserInfo(user: user)
        }
    }
    
    func showUserInfo(user: User) { }
    
    func showLoginVC() {
        let authUI = FUIAuth.defaultAuthUI()
        let providers = [FUIEmailAuth()]
        authUI?.providers = providers
        guard let authViewController = authUI?.authViewController() else { return }
        authViewController.modalPresentationStyle = .overCurrentContext
        present(authViewController, animated: true, completion: nil)
    }
}

extension FUIAuthBaseViewController{
    open override func viewWillAppear(_ animated: Bool) {
        navigationItem.leftBarButtonItem = nil
    }
}


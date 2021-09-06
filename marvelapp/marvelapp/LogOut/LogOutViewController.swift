//
//  LogOutViewController.swift
//  marvelapp
//
//  Created by Juliana Pardal on 04/09/2021.
//

import UIKit
import FirebaseAuth

protocol LogOutDelegate: class {
    func selectPreviousIndex()
}

class LogOutViewController: UIViewController {
    
    weak var delegate: LogOutDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        createAlert()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createAlert()
    }
    
    private func createAlert() {
        let alert = UIAlertController(title: "Are you sure you want to logout?", message: "You can always access your content by signing back in.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] _ in
            self?.signOut()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { [weak self] _ in
            self?.delegate?.selectPreviousIndex()
        } ))
        present(alert, animated: true, completion: nil)
    }
    
    private func login(withEmail email: String, password: String, _ callback: ((Error?) -> ())? = nil) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                callback?(error)
                return
            }
            callback?(nil)
        }
    }
    
    private func signOut() {
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

//
//  Register.swift
//  marvelapp
//
//  Created by Juliana Pardal on 29/08/2021.
//

import Foundation
import FirebaseAuth

class SignUp {
    let email = "example@gmail.com"
    let password = "testtest"
    
    func createUser(email: String, password: String) {
        /*Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard let error = error as? Error else {
                print("User signs up successfully")
                let newUserInfo = Auth.auth().currentUser
                let email = newUserInfo?.email
                return
            }
            switch AuthErrorCode(rawValue: error.code) {
            case .operationNotAllowed:
              // Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.
            case .emailAlreadyInUse:
              // Error: The email address is already in use by another account.
            case .invalidEmail:
              // Error: The email address is badly formatted.
            case .weakPassword:
              // Error: The password must be 6 characters long or more.
            default:
                print("Error: \(error.localizedDescription)")
            }
        }*/
    }
}

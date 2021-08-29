//
//  ViewController.swift
//  marvelapp
//
//  Created by Juliana Pardal on 29/08/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { auth, user in
          // ...
        }
    }

}


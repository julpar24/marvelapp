//
//  HomeScreenViewController.swift
//  marvelapp
//
//  Created by Juliana Pardal on 30/08/2021.
//

import UIKit

class HomeScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBarController()
    }

    func createTabBarController() {
        let charactersVC = CharactersViewController()
        let eventsVC = EventsViewController()
        let logoutVC = UIAlertController(title: "Are you sure you want to logout?", message: "You can always access your content by signing back in.", preferredStyle: .alert)
        logoutVC.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        logoutVC.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [charactersVC, eventsVC, logoutVC]
        tabBarController.selectedViewController = charactersVC
        present(tabBarController, animated: true, completion: nil)
    }

}

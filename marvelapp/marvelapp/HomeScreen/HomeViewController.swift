//
//  HomeViewController.swift
//  marvelapp
//
//  Created by Juliana Pardal on 30/08/2021.
//

import UIKit

class HomeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    func configureTabBar() {
        let charactersItem = UITabBarItem(title: "Characters", image: #imageLiteral(resourceName: "icon-superhero_disabled"), selectedImage: #imageLiteral(resourceName: "icon-superhero"))
        let charactersVC = ViewControllerFactory.showCharactersViewController()
        charactersVC.tabBarItem = charactersItem
        
        let eventsItem = UITabBarItem(title: "Events", image: #imageLiteral(resourceName: "icon-calendar_disabled"), selectedImage: #imageLiteral(resourceName: "icon-calendar"))
        let eventsVC = ViewControllerFactory.showEventsViewController()
        eventsVC.tabBarItem = eventsItem
        
        let logoutItem = UITabBarItem(title: "Log Out", image: #imageLiteral(resourceName: "logout"), selectedImage: #imageLiteral(resourceName: "logout"))
        let logoutVC = ViewControllerFactory.logOutViewController()
        logoutVC.tabBarItem = logoutItem

        viewControllers = [charactersVC, eventsVC, logoutVC]
        selectedViewController = charactersVC
    }
}

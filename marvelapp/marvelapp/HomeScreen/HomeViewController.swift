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
        /*let logoutVC = UIAlertController(title: "Are you sure you want to logout?", message: "You can always access your content by signing back in.", preferredStyle: .alert)
        logoutVC.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        logoutVC.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
 */
        viewControllers = [charactersVC, eventsVC]
        selectedViewController = charactersVC
    }
}

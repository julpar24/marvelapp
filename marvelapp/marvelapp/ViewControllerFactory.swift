//
//  ViewControllerFactory.swift
//  marvelapp
//
//  Created by Juliana Pardal on 02/09/2021.
//

import UIKit

class ViewControllerFactory {
    private class func controller<T: UIViewController>(type: T.Type) -> T {
        return T.init(nibName: type.className, bundle: nil)
    }
    
    class func loginViewController() -> LoginViewController {
        let returnable = controller(type: LoginViewController.self)
        return returnable
    }
    
    class func showCharactersViewController() -> CharactersViewController {
        let returnable = controller(type: CharactersViewController.self)
        let model = CharactersViewModel()
        model.delegate = returnable
        returnable.model = model
        return returnable
    }
    
    class func showEventsViewController() -> EventsViewController {
        let returnable = controller(type: EventsViewController.self)
        let model = EventsViewModel()
        model.delegate = returnable
        returnable.model = model
        return returnable
    }
    
    class func logOutViewController() -> LogOutViewController {
        let returnable = controller(type: LogOutViewController.self)
        return returnable
    }
    
    class func characterDetail(character: Character) -> CharacterDetailViewController {
        let returnable = controller(type: CharacterDetailViewController.self)
        let model = CharacterDetailViewModel(character: character)
        model.delegate = returnable
        returnable.model = model
        return returnable
    }
    
    class func eventDetail(event: Event) -> EventDetailViewController {
        let returnable = controller(type: EventDetailViewController.self)
        let model = EventDetailViewModel(event: event)
        model.delegate = returnable
        returnable.model = model
        return returnable
    }
}

extension UIViewController {
    class var className: String {
        return String(describing: Self.self)
    }
}

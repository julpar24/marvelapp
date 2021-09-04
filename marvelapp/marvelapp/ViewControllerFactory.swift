//
//  ViewControllerFactory.swift
//  marvelapp
//
//  Created by Juliana Pardal on 02/09/2021.
//

import UIKit

class ViewControllerFactory {
    private class func controllerFromNib<T: UIViewController>(type: T.Type) -> T {
        return T.init(nibName: type.className, bundle: nil)
    }
    
    class func showCharactersViewController() -> CharactersViewController {
        let returnable = controllerFromNib(type: CharactersViewController.self)
        let model = CharactersViewModel()
        model.delegate = returnable
        returnable.model = model
        return returnable
    }
    
    class func showEventsViewController() -> EventsViewController {
        let returnable = controllerFromNib(type: EventsViewController.self)
        let model = EventsViewModel()
        model.delegate = returnable
        returnable.model = model
        return returnable
    }
    
    class func characterDetail(character: Character) -> CharacterDetailViewController {
        let returnable = controllerFromNib(type: CharacterDetailViewController.self)
        let model = CharacterDetailViewModel(character: character)
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

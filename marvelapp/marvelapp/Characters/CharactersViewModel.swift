//
//  CharactersViewModel.swift
//  marvelapp
//
//  Created by Juliana Pardal on 31/08/2021.
//

import Foundation

class CharactersViewModel {
    // MARK: - Variables and constants
    let cellIdentifier = "CharacterCell"
    var elements = [CharacterInfoCell]()
    
    var numberOfItems: Int {
        return 0
    }

    // MARK: - Functions
    func identifierForCell(atIndexPath indexPath: IndexPath) -> String {
        return cellIdentifier
    }

    func objectForCell(atIndexPath indexPath: IndexPath) -> Any? {
        return elements[indexPath.row]
    }
}

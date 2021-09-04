//
//  CharactersViewModel.swift
//  marvelapp
//
//  Created by Juliana Pardal on 31/08/2021.
//

import UIKit

protocol CharactersViewModelDelegate: class {
    func dataSourceWasUpdated()
}

class CharactersViewModel: CollectionDataSource {
    // MARK: - Variables and constants
    let cellIdentifier = "CharacterCell"
    var characters = [Character]()
    var events = [Event]()
    let charactersRequest = GETCharacters()
    let apiDataManager = MarvelAPIClient(publicKey: "810a2f2d49fa97e196e57c8970b5e80b", privateKey: "f4de99d64c6bccf9d326bbb8101775315fa39f49", resourceName: "", shouldAddIdToRequest: true)
    
    weak var delegate: CharactersViewModelDelegate?
    
    var numberOfItems: Int {
        return characters.count
    }

    init(delegate: CharactersViewModelDelegate? = nil) {
        self.delegate = delegate
    }    
    
    // MARK: - Functions
    func identifierForCell(atIndexPath indexPath: IndexPath) -> String {
        return cellIdentifier
    }
    
    func element(for indexPath: IndexPath) -> Character {
        return characters[indexPath.row]
    }
    
    func itemSize(forIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: ScreenSize.width - 16, height: 120)
    }
    
    func getElementsInfo() {
        apiDataManager.send(charactersRequest) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let elements):
                self.characters = elements.results
                self.delegate?.dataSourceWasUpdated()
            case .failure(_):
                //TODO: handle error
                //print(error.description)
                break
            }
        }
    }
}

// MARK: - CollectionDataSource
extension CharactersViewModel {
    func numberOfRows(inSection section: Int) -> Int {
        return characters.count
    }

    func objectForRow(atIndexPath indexPath: IndexPath) -> Any? {
        let character = characters[indexPath.row]
        return CharacterCellConfiguration(elementName: character.name, elementInfo: character.description, image: character.thumbnail)
    }

    func inset(forSection section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 9, left: 0, bottom: 9, right: 0)
    }

    func minimumLineSpacing(forSectionAt section: Int) -> CGFloat {
        return 9.0
    }

    func minimumInteritemSpacing(forSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

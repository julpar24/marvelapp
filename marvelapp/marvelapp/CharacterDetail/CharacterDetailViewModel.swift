//
//  CharacterDetailViewModel.swift
//  marvelapp
//
//  Created by Juliana Pardal on 02/09/2021.
//

import UIKit
import SDWebImage

protocol CharacterDetailViewModelDelegate: class {
    func dataSourceWasUpdated()
}

class CharacterDetailViewModel {
    // MARK: - Variables and constants
    let cellIdentifier = "ComicAppearanceCell"
    var character: Character
    var comics = [Comic]()
    var request: GETComics
    let apiDataManager = MarvelAPIClient(publicKey: "810a2f2d49fa97e196e57c8970b5e80b", privateKey: "f4de99d64c6bccf9d326bbb8101775315fa39f49")
    
    weak var delegate: CharacterDetailViewModelDelegate?
    
    var numberOfItems: Int {
        return comics.count
    }
    
    var image: URL? {
        return character.thumbnail?.url
    }
    
    var characterInfo: String? {
        return character.description
    }
    
    var name: String? {
        return character.name
    }

    init(delegate: CharacterDetailViewModelDelegate? = nil, character: Character) {
        self.delegate = delegate
        self.character = character
        request = GETComics(id: character.id)
    }
    
    // MARK: - Functions
    func identifierForCell(atIndexPath indexPath: IndexPath) -> String {
        return cellIdentifier
    }

    func objectForCell(atIndexPath indexPath: IndexPath) -> Any? {
        let comic = comics[indexPath.row]
        let date = comic.modified ?? ""
        let index = date.firstIndex(of: "-") ?? date.endIndex
        let year = String(date[..<index])
        return ComicAppearanceCellConfiguration(comic: comic.title, year: year)
    }
    
    func character(for indexPath: IndexPath) -> Comic {
       return comics[indexPath.row]
    }
    
    func getComicsInfo() {
        apiDataManager.send(request) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let comics):
                self.comics = comics.results
                self.delegate?.dataSourceWasUpdated()
            case .failure(_):
                //TODO: handle error
                //print(error.description)
                break
            }
        }
    }
}

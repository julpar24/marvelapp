//
//  EventDetailViewModel.swift
//  marvelapp
//
//  Created by Juliana Pardal on 04/09/2021.
//

import UIKit
import SDWebImage

protocol EventDetailViewModelDelegate: class {
    func dataSourceWasUpdated()
}

class EventDetailViewModel {
    // MARK: - Variables and constants
    let cellIdentifier = "ComicAppearanceCell"
    var event: Event
    var comics = [Comic]()
    var request: GETComics
    let apiDataManager = MarvelAPIClient(publicKey: "810a2f2d49fa97e196e57c8970b5e80b", privateKey: "f4de99d64c6bccf9d326bbb8101775315fa39f49", resourceName: "events/", shouldAddIdToRequest: true)
    
    weak var delegate: EventDetailViewModelDelegate?
    
    var numberOfItems: Int {
        return comics.count
    }
    
    var image: URL? {
        return event.thumbnail?.url
    }
    
    var eventInfo: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: event.modified ?? "")
        return date?.dateInNaturalLanguage()
    }
    
    var title: String? {
        return event.title
    }

    init(delegate: EventDetailViewModelDelegate? = nil, event: Event) {
        self.delegate = delegate
        self.event = event
        request = GETComics(id: event.id)
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
    
    func comic(for indexPath: IndexPath) -> Comic {
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

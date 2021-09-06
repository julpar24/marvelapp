//
//  EventDetailViewModel.swift
//  marvelapp
//
//  Created by Juliana Pardal on 04/09/2021.
//

import UIKit
import SDWebImage

protocol EventDetailViewModelDelegate: class {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
}

class EventDetailViewModel {
    // MARK: - Variables and constants
    let cellIdentifier = "ComicAppearanceCell"
    var event: Event
    var comics = [Comic]()
    var totalPages = 1
    var currentPage = 0
    let limit = 15
    var isLoading = false
    var hasNextPage = true
    let apiDataManager = MarvelAPIClient(publicKey: "810a2f2d49fa97e196e57c8970b5e80b", privateKey: "f4de99d64c6bccf9d326bbb8101775315fa39f49", resourceName: "events/", shouldAddIdToRequest: false)
    
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
        guard !isLoading else { return }
        guard hasNextPage else { return }
        isLoading = true
        apiDataManager.send(GETComics(offset: currentPage * limit, id: event.id)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let comics):
                self.isLoading = false
                self.totalPages = comics.total % self.limit == 0 ? comics.total / self.limit : comics.total / self.limit + 1
                self.hasNextPage = self.currentPage < self.totalPages
                if self.hasNextPage {
                    self.currentPage += 1
                }
                self.comics.append(contentsOf: comics.results)
                self.delegate?.onFetchCompleted(with: [])
            case .failure(_):
                //TODO: handle error
                break
            }
        }
    }
}

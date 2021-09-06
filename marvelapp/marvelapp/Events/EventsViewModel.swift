//
//  EventsViewModel.swift
//  marvelapp
//
//  Created by Juliana Pardal on 03/09/2021.
//

import UIKit

protocol EventsViewModelDelegate: class {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
}

class EventsViewModel {
    // MARK: - Variables and constants
    let cellIdentifier = "CharacterCell"
    var events = [Event]()
    var totalPages = 1
    var currentPage = 0
    let limit = 25
    var isLoading = false
    var hasNextPage = true
    var apiDataManager = MarvelAPIClient(publicKey: "810a2f2d49fa97e196e57c8970b5e80b", privateKey: "f4de99d64c6bccf9d326bbb8101775315fa39f49", resourceName: "", shouldAddIdToRequest: true)
    
    weak var delegate: EventsViewModelDelegate?
    
    var numberOfItems: Int {
        return events.count
    }

    init(delegate: EventsViewModelDelegate? = nil) {
        self.delegate = delegate
    }
    
    // MARK: - Functions
    func identifierForCell(atIndexPath indexPath: IndexPath) -> String {
        return cellIdentifier
    }
    
    func event(for indexPath: IndexPath) -> Event {
        return events[indexPath.row]
    }
    
    func itemSize(forIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: ScreenSize.width - 16, height: 120)
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        return events.count
    }

    func objectForRow(atIndexPath indexPath: IndexPath) -> Any? {
        let element = events[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: element.modified ?? "")
        return CharacterCellConfiguration(elementName: element.title, elementInfo: date?.dateInNaturalLanguage(), image: element.thumbnail)
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
    
    func getElementsInfo(resetList: Bool) {
        guard !isLoading else { return }
        if resetList {
            hasNextPage = true
            currentPage = 0
        }
        guard hasNextPage else { return }
        isLoading = true
        apiDataManager.send(GETEvents(offset: currentPage * limit)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let elements):
                self.isLoading = false
                self.totalPages = elements.total % self.limit == 0 ? elements.total / self.limit : elements.total / self.limit + 1
                self.hasNextPage = self.currentPage < self.totalPages
                if self.hasNextPage {
                    self.currentPage += 1
                }
                if resetList {
                    self.events = []
                }
                self.events.append(contentsOf: elements.results)
                self.delegate?.onFetchCompleted(with: [])
            case .failure(_):
                //TODO: handle error
                break
            }
        }
    }
}


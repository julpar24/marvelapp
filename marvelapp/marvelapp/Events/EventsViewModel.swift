//
//  EventsViewModel.swift
//  marvelapp
//
//  Created by Juliana Pardal on 03/09/2021.
//

import UIKit

protocol EventsViewModelDelegate: class {
    func dataSourceWasUpdated()
}

class EventsViewModel {
    // MARK: - Variables and constants
    let cellIdentifier = "CharacterCell"
    var events = [Event]()
    let eventsRequest = GETEvents()
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
    
    func getElementsInfo() {
        apiDataManager.send(eventsRequest) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let elements):
                self.events = elements.results
                self.delegate?.dataSourceWasUpdated()
            case .failure(_):
                //TODO: handle error
                //print(error.description)
                break
            }
        }
    }
}


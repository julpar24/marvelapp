//
//  CharacterComicConfigurations.swift
//  marvelapp
//
//  Created by Juliana Pardal on 03/09/2021.
//

import UIKit

protocol CollectionDataSource {
    func numberOfRows(inSection section: Int) -> Int
    func objectForRow(atIndexPath indexPath: IndexPath) -> Any?
    func inset(forSection section: Int) -> UIEdgeInsets
    func minimumLineSpacing(forSectionAt section: Int) -> CGFloat
    func minimumInteritemSpacing(forSectionAt section: Int) -> CGFloat
}

enum EventCharacterType {
    case characters, events

    var endpointType: String {
        switch self {
        case .characters: return "characters"
        case .events: return "comics"
        }
    }
}

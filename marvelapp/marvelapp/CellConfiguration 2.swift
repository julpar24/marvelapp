//
//  CellConfiguration.swift
//  marvelapp
//
//  Created by Juliana Pardal on 31/08/2021.
//

import UIKit

protocol CellConfiguration {
    func configure(with object: Any?)
}

protocol CellConfigurable {
    var identifier: String { get }
    var size: CGSize { get }
}

class CharacterCellConfiguration: CellConfigurable {
    var identifier: String { return "CharacterCell" }
    var size: CGSize { return CGSize(width: UIScreen.main.bounds.width - 16, height: 120.0) }

    var characterName: String?
    var characterDescription: String?
    var imageURL: URL?

    init(characterName: String? = nil, characterDescription: String? = nil, imageURL: URL? = nil) {
        self.characterName = characterName
        self.characterDescription = characterDescription
        self.imageURL = imageURL
    }
}

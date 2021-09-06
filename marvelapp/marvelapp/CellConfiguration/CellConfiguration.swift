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
    var size: CGSize { return CGSize(width: ScreenSize.width - 16, height: 120.0) }

    var elementName: String?
    var elementInfo: String?
    var image: Image?

    init(elementName: String? = nil, elementInfo: String? = nil, image: Image? = nil) {
        self.elementName = elementName
        self.elementInfo = elementInfo
        self.image = image
    }
}

class ComicAppearanceCellConfiguration: CellConfigurable {
    var identifier: String { return "ComicAppearanceCell" }
    var size: CGSize { return CGSize(width: ScreenSize.width, height: 88.0) }

    var comic: String?
    var year: String?

    init(comic: String? = nil, year: String? = nil) {
        self.comic = comic
        self.year = year
    }
}

//
//  ComicCharacter.swift
//  marvelapp
//
//  Created by Juliana Pardal on 01/09/2021.
//

import Foundation

open class Character: Decodable {
    let id: Int
    let name: String?
    let description: String?
    let thumbnail: Image?
}

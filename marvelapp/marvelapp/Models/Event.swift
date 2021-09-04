//
//  Event.swift
//  marvelapp
//
//  Created by Juliana Pardal on 03/09/2021.
//

import Foundation

open class Event: Decodable {
    let id: Int
    let title: String?
    let description: String?
    let modified: String?
    let thumbnail: Image?
}

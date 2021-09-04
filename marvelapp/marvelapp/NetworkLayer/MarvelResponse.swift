//
//  MarvelResponse.swift
//  marvelapp
//
//  Created by Juliana Pardal on 01/09/2021.
//

import Foundation

struct MarvelResponse<Response: Decodable>: Decodable {
    let status: String?
    let message: String?
    let data: DataContainer<Response>?
}

struct DataContainer<Results: Decodable>: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: Results
}

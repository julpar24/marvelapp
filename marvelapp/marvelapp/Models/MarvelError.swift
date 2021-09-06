//
//  MarvelError.swift
//  marvelapp
//
//  Created by Juliana Pardal on 06/09/2021.
//

import Foundation

public enum MarvelError: Error {
    case encoding
    case decoding
    case server(message: String)
    case invalidURL
    case parseFailure
    case emptyData
}

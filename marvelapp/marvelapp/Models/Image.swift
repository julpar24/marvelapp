//
//  Image.swift
//  marvelapp
//
//  Created by Juliana Pardal on 01/09/2021.
//

import Foundation

struct Image: Decodable {
    enum ImageKeys: String, CodingKey {
        case path = "path"
        case fileExtension = "extension"
    }

    let url: URL

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ImageKeys.self)

        let path = try container.decode(String.self, forKey: .path)
        let fileExtension = try container.decode(String.self, forKey: .fileExtension)

        guard let url = URL(string: "\(path).\(fileExtension)") else { throw MarvelError.decoding }

        self.url = url
    }
}

public enum MarvelError: Error {
    case encoding
    case decoding
    case server(message: String)
    case invalidURL
    case parseFailure
    case emptyData
}

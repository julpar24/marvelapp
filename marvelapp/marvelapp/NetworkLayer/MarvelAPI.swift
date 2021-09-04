//
//  MarvelAPI.swift
//  marvelapp
//
//  Created by Juliana Pardal on 01/09/2021.
//

protocol APIClient {
    func send<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<T.Response>)
}

protocol APIRequest: Encodable {
    associatedtype Response: Decodable

    /// Endpoint for this request
    var resourceName: String { get }
}

struct GETCharacters: APIRequest {
    var resourceName: String {
        return "characters"
    }
    
    typealias Response = [Character]

    // Parameters
    let name: String?
    let nameStartsWith: String?
    let limit: Int?
    let offset: Int?

    init(name: String? = nil, nameStartsWith: String? = nil, limit: Int? = nil, offset: Int? = nil) {
        self.name = name
        self.nameStartsWith = nameStartsWith
        self.limit = limit
        self.offset = offset
    }
}

struct GETEvents: APIRequest {
    var resourceName: String {
        return "events"
    }
    
    typealias Response = [Event]

    // Parameters
    let name: String?
    let nameStartsWith: String?
    let limit: Int?
    let offset: Int?

    init(name: String? = nil, nameStartsWith: String? = nil, limit: Int? = nil, offset: Int? = nil) {
        self.name = name
        self.nameStartsWith = nameStartsWith
        self.limit = limit
        self.offset = offset
    }
}


struct GETComics: APIRequest {
    typealias Response = [Comic]
    
    var id: Int
    
    var resourceName: String {
        return "characters/\(id)/comics"
    }
    
    // Parameters
    let title: String?
    let titleStartsWith: String?
    let limit: Int?
    let offset: Int?

    init(title: String? = nil, titleStartsWith: String? = nil, limit: Int? = nil, offset: Int? = nil, id: Int) {
        self.title = title
        self.titleStartsWith = titleStartsWith
        self.limit = limit
        self.offset = offset
        self.id = id
    }
}

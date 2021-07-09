//
//  URLProvider.swift
//  SwiftHubApp
//
//  Created by Ederson Machado Berti on 01/07/21.
//

import Foundation

protocol URLProvider {
    var url: URL? { get }
}

// MARK: - fixed urls
struct FullURLSpecified: URLProvider {
    let url: URL?

    init(path: String) {
        self.url = URL(string: path)
    }
}

// MARK: - endpoints
let baseAPIUrl = "https://api.github.com"

struct SearchAPIURLProvider: URLProvider {
    let url: URL?

    init(endpoint: Endpoint) {
        url = Self.buildURL(with: endpoint)
    }

    static func buildURL(with endpoint: Endpoint) -> URL? {
        guard var url = URL(string: baseAPIUrl) else { return nil }

        url.appendPathComponent("search")
        url.appendPathComponent("repositories")
        
        endpoint.query.forEach { name, value in
            url.append(name, value: value)
        }
        
        return url
    }

    enum Endpoint {
        case search(language: String)
        case searchBy(text: String)
        
        var query: [(String, String)] {
            switch self {
            case .search(let language):
                return [
                    ("q", "language:\(language)"), ("sort", "stars")
                ]
            case .searchBy(let text):
                return [
                    ("q", text), ("sort", "stars")
                ]
            }
        }
    }
}

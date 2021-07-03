//
//  SearchResult.swift
//  SwiftHubApp
//
//  Created by Ederson Machado Berti on 01/07/21.
//

import Foundation

struct SearchResult: Decodable {
    let totalCount: Int
    let items: [Repository]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}

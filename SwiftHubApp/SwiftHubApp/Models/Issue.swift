//
//  Issue.swift
//  SwiftHubApp
//
//  Created by Ederson Machado Berti on 05/07/21.
//

import Foundation

// URL repos/{owner}/{repo}/issues

struct Issue: Decodable, Identifiable {
    let comments: Int
    let created: Date
    let creator: Creator
    let description: String
    let id: Int
    let number: Int
    let state: State
    let title: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case comments
        case created = "created_at"
        case creator = "user"
        case description = "body"
        case id
        case number
        case state
        case title
        case url = "html_url"
    }
    
    enum State: String, Decodable {
        case closed
        case open
    }
    
    struct Creator: Decodable {
        let login: String
    }
}

//
//  User.swift
//  SwiftHubApp
//
//  Created by Ederson Machado Berti on 01/07/21.
//

import Foundation

struct User: Decodable {
    let name: String
    let bio: String?
    let type: UserType
    let pictureURL: String
    let profileURL: String
    let email: String?
    let blog: String?
    let followers: Int
    let following: Int
    let repos: Int
    
    enum UserType: String, Decodable {
        case organization = "Organization"
        case user = "User"
    }

    enum CodingKeys: String, CodingKey {
        case name = "login"
        case bio
        case type
        case pictureURL = "avatar_url"
        case profileURL = "url"
        case email
        case blog
        case followers
        case following
        case repos = "public_repos"
    }
}

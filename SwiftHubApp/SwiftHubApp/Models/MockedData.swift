//
//  MockedData.swift
//  SwiftHubApp
//
//  Created by Ederson Machado Berti on 01/07/21.
//

import Foundation

let babyCorgiPic = "https://static.boredpanda.com/blog/wp-content/uploads/2020/08/CBr78muJnaq-png__700.jpg"
let mockUserURL = "https://api.github.com/users/AFNetworking"

let userSrc = """
{
  "login": "Baby Corgi",
  "avatar_url": "\(babyCorgiPic)",
  "url": "https://api.github.com/users/AFNetworking",
  "type": "Organization",
  "name": "AFNetworking",
  "blog": "http://afnetworking.com",
  "email": "info@alamofire.org",
  "bio": "A delightful iOS and OS X networking framework",
  "public_repos": 22,
  "followers": 0,
  "following": 0,
  "created_at": "2011-11-08T19:08:12Z",
  "updated_at": "2015-04-27T20:37:08Z"
}

"""

extension Repository {
    static var mocked: Repository {
        Repository(id: 1000,
                   owner: .init(name: "Baby Corgi", pictureURL: babyCorgiPic, profileURL: mockUserURL),
                   name: "AFNetworking",
                   description: "A delightful blabber; a 5-month-old pup who can't stay still, constantly making everyone around her smile like idiots",
                   starCount: 200,
                   language: "Português",
                   webPage: "www.github.com",
                   watchers: 100,
                   openIssues: 2,
                   forks: 30,
                   license: .init(name: "Mitch", url: mockUserURL),
                   created: .init(timeIntervalSinceReferenceDate: 0),
                   lastUpdated: Date())
    }
}

extension User {
    static var mocked: User? {
        guard let json = userSrc.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(User.self, from: json)
    }
}

extension Issue {
    static var mocked: Issue {
        Issue(comments: 1,
              created: .init(timeIntervalSinceReferenceDate: 0),
              creator: Creator(login: "ahoppen"),
              description: "Resolves rdar://78011350",
              id: 10,
              number: 100,
              state: Issue.State.open,
              title: "[Async Refactoring] Get semantics providing expr to decide if call is to completion handler",
              url: "https://github.com/apple/swift/pull/38261")
    }
}

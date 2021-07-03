//
//  SwiftHubAppApp.swift
//  SwiftHubApp
//
//  Created by Ederson Machado Berti on 01/07/21.
//

import SwiftUI

@main
struct SwiftHubAppApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                RepositoryListView()
                    .tabItem {
                    Text("Mobile Repositories")
                    Image(systemName: "iphone")
                }
                .accentColor(.white)
                RepositorySearchView()
                    .tabItem {
                    Text("Search")
                    Image(systemName: "magnifyingglass")
                }
                .accentColor(.white)
            }
        }
    }
}

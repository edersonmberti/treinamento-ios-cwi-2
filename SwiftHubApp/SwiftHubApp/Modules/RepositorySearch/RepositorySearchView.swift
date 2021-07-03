//
//  RepositorySearchView.swift
//  SwiftHubApp
//
//  Created by Ederson Machado Berti on 03/07/21.
//

import SwiftUI

struct RepositorySearchView: View {
    @ObservedObject var viewModel: RepositorySearchViewModel = .init()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: SearchBar(text: $viewModel.searchText)) {
                    ForEach(viewModel.repositories) { item in
                        NavigationLink(destination:
                            RepositoryDetailView(repository: item)) {
                            RepositoryView(repository: item)
                        }
                    }
                }
            }
            .navigationBarTitle("Search: \(viewModel.searchText)")
        }
    }
}

struct RepositorySearchView_Previews: PreviewProvider {
    static var previews: some View {
        let view = RepositorySearchView()
        view.configNavigationBar()
        view.viewModel.repositories = [
            .mocked, .mocked, .mocked,
            .mocked, .mocked, .mocked,
            .mocked, .mocked, .mocked,
            .mocked, .mocked, .mocked,
        ]
        return view
    }
}

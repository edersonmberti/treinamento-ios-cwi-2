//
//  RepositoryListViewModel.swift
//  SwiftHubApp
//
//  Created by Ederson Machado Berti on 01/07/21.
//

import SwiftUI

// Design Pattern Obsarvable

class RepositoryListViewModel: ObservableObject {
    @Published var repositories: [Repository] = []
    @Published var isLoading: Bool = false
    @Published var requestError: APIError?
    @Published var selectedLanguage: Language = .swift {
        didSet {
            fetchData()
        }
    }
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        let provider = SearchAPIURLProvider(endpoint: .search(language: selectedLanguage.rawValue))
        isLoading = true
        requestError = nil
        repositories = []
        
        Requester.request(search: provider) { [weak self] (result: Result<SearchResult, APIError>) in
            switch result {
            case .success(let searchResult):
                DispatchQueue.main.async {
                    self?.repositories = searchResult.items
                    self?.isLoading = false
                }
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.requestError = error
                }
            }
        }
    }
}

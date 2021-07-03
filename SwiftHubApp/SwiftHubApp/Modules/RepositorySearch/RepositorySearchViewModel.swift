//
//  RepositorySearchViewModel.swift
//  SwiftHubApp
//
//  Created by Ederson Machado Berti on 03/07/21.
//

import Combine
import Foundation

class RepositorySearchViewModel: ObservableObject {
    @Published var repositories: [Repository] = []
    @Published var searchText: String = ""
    
    var subscriptions: Set<AnyCancellable> = []
    
    init() {
        $searchText
            .debounce(for: .milliseconds(400), scheduler: DispatchQueue.main)
            .dropFirst()
            .sink(receiveValue: { [unowned self] value in
                print(value)
                self.search()
            })
            .store(in: &subscriptions)
    }
    
    private func search() {
        CombineRequester.request(search: .init(endpoint: .searchBy(text: searchText)))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { [unowned self] ( result: SearchResult ) in
                self.repositories = result.items
            })
            .store(in: &subscriptions)
    }
    
//    private func valdisney(set: inout Set<String>) {
//        let oito = set
//        set.insert("10")
//    }
}

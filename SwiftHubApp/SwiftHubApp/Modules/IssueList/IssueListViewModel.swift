//
//  IssueListViewModel.swift
//  SwiftHubApp
//
//  Created by Ederson Machado Berti on 05/07/21.
//

import Combine
import Foundation

class IssueListViewModel: ObservableObject {
    @Published var issues: [Issue] = []
    @Published var requestError: APIError?
    @Published var status: Status = .loading
    
    var owner: String = ""
    var repo: String = ""
    
    var subscriptions: Set<AnyCancellable> = []
    
    init(owner: String, repo: String) {
        self.owner = owner
        self.repo  = repo
        
        fetchData()
    }
    
    func fetchData() {
        status = .loading
        let url = FullURLSpecified(path: "https://api.github.com/repos/\(self.owner)/\(self.repo)/issues")
        
        CombineRequester.request(with: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self.requestError = error
                    self.status = .error
                }
            }, receiveValue: { [unowned self] ( result: [Issue] ) in
                self.issues = result
                status = .success
            })
            .store(in: &subscriptions)
    }
}

enum Status {
    case loading
    case success
    case error
}

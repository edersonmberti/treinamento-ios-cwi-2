//
//  UserDetailViewModel.swift
//  SwiftHubApp
//
//  Created by Ederson Machado Berti on 02/07/21.
//

import SwiftUI

class UserDetailViewModel: ObservableObject {
    @Published var user: User?
    
    init(url: String) {
        fetchUserData(with: url)
    }
    
    func fetchUserData(with url: String) {
        Requester.request(with: .init(path: url)) { [weak self] (result: Result<User, APIError>) in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self?.user = user
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

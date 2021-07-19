//
//  Service.swift
//  ExerciciOS
//
//  Created by Fabricio Cordella on 09/07/21.
//

import Combine
import Foundation

enum ServiceError: Error {
    case invalidUrl
    case decodeError
}

enum Endpoint: String {
    private var baseUrl: String  { "http://localhost:3000" }
    
    case workouts = "/exercicios"
    
    var url: URL {
        URL(string: baseUrl+self.rawValue)!
    }
}

class Service {
    static func request<T:Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T,ServiceError> {
        return URLSession.shared.dataTaskPublisher(for: endpoint.url)
            .mapError { error in
                ServiceError.invalidUrl
            }
            .tryMap(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                return ServiceError.decodeError
            }
            .eraseToAnyPublisher()
    }
}

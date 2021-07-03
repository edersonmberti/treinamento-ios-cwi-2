//
//  CombineRequester.swift
//  SwiftHubApp
//
//  Created by Ederson Machado Berti on 03/07/21.
//

import Combine
import Foundation

struct CombineRequester {
    static func request<T: Decodable>(with url: FullURLSpecified) -> AnyPublisher<T, APIError> {
        request(from: url)
    }

    static func request<T: Decodable>(search: SearchAPIURLProvider) -> AnyPublisher<T, APIError> {
        request(from: search)
    }
    
    private static func request<T:Decodable>(from urlProvider: URLProvider) -> AnyPublisher<T, APIError> {
        guard let url = urlProvider.url else {
            return Fail(error: APIError.malformedURL).eraseToAnyPublisher()
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        return URLSession.shared.dataTaskPublisher(for: url).tryMap { ( result ) in
            guard let httpUrlResponse = result.response as? HTTPURLResponse, 200..<299 ~= httpUrlResponse.statusCode else {
                throw APIError.invalidResponse
            }
            
            return result.data
        }
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
            return APIError.decodeError
        }
        .eraseToAnyPublisher()
    }
}

//
//  Requester.swift
//  SwiftHubApp
//
//  Created by Ederson Machado Berti on 01/07/21.
//

import Foundation

typealias RequestCallback<T> = (Result<T, APIError>) -> Void

struct Requester {
    static func request<T: Decodable>(with url: FullURLSpecified, completion: @escaping RequestCallback<T>) {
        request(from: url, completion: completion)
    }

    static func request<T: Decodable>(search: SearchAPIURLProvider, completion: @escaping RequestCallback<T>) {
        request(from: search, completion: completion)
    }

    private static func request<T: Decodable>(from urlProvider: URLProvider, completion: @escaping RequestCallback<T>) {
        guard let url = urlProvider.url else {
            completion(.failure(.malformedURL))
            return
        }

        URLSession.shared.dataTask(with: url) { result in
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    completion(.failure(.invalidResponse))
                    return
                }

                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                do {
                    let values = try decoder.decode(T.self, from: data)
                    completion(.success(values))
                } catch {
                    print(error)
                    completion(.failure(.decodeError))
                }
            case .failure(_):
                completion(.failure(.apiError))
            }
        }.resume()
    }
}

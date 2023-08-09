//
//  NetworkService.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 09.08.2023.
//

import SwiftUI
import Foundation

enum NetworkError: Error {
    case badURL
    case noData
    case decodingError
}

class NetworkService {
    func fetch<T: Decodable>(urlRequest: URLRequest, completion: @escaping ((Result<T, NetworkError>) -> Void)) {
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(.success(model))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(.decodingError))
            }
        }
        .resume()
    }
}

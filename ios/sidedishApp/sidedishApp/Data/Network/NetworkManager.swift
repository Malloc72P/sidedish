//
//  NetworkManager.swift
//  sidedishApp
//
//  Created by zombietux on 2021/04/20.
//

import Foundation
import Combine

protocol HttpMethodProtocol: class {
    func get<T>(type: T.Type, url: URL) -> AnyPublisher<T, Error> where T: Decodable
}

protocol HttpPostMethodProtocol: class {
    func post(quantity: Int, url: URL) -> AnyPublisher<Int, NetworkError>
}

enum NetworkError: Error {
    case urlError
    case httpError
}

class NetworkManager: HttpMethodProtocol {
    func get<T>(type: T.Type, url: URL) -> AnyPublisher<T, Error> where T : Decodable {
        let urlRequest = URLRequest(url: url)
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

class PostNetworkManager: HttpPostMethodProtocol {
    func post(quantity: Int, url: URL) -> AnyPublisher<Int, NetworkError> {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let postJson: [String: Int] = ["quantity" : quantity]
        let postJsonData = try? JSONSerialization.data(withJSONObject: postJson)
        
        request.httpBody = postJsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap{ data , response -> Int in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.httpError
                }
                guard 200..<300 ~= httpResponse.statusCode else {
                    throw NetworkError.httpError
                }
                
                return httpResponse.statusCode
            }
            .mapError {$0 as! NetworkError }
            .eraseToAnyPublisher()
    }
}

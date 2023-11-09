//
//  NetworkManager.swift
//  BTC-Tracker
//
//  Created by Sizwe Maluleke on 2023/11/08.
//

import Combine
import Foundation

class NetworkManager {
    let apiKey: String
    let baseURL: String

    init(apiKey: String, baseURL: String) {
        self.apiKey = apiKey
        self.baseURL = baseURL
    }

    func fetchData<T: Decodable>(forEndpoint endpoint: String) -> AnyPublisher<T, Error> {
        let url = URL(string: baseURL + endpoint)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "apikey")

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

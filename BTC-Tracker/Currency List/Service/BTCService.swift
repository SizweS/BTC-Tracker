//
//  BTCService.swift
//  BTC-Tracker
//
//  Created by Sizwe Maluleke on 2023/11/08.
//

import Foundation

import Combine
import Foundation

class BTCService {
    private let networkManager: NetworkManager
    private let baseUrl = "https://api.apilayer.com/fixer/"
    private let apiKey = "1yJg56aYgDPSAwO5mMhmq7I8AMxje8Zs"

    init() {
        self.networkManager = NetworkManager(apiKey: apiKey, baseURL: baseUrl)
    }

    func fetchCurrencyRates() -> AnyPublisher<Currency, Error> {
        return networkManager.fetchData(forEndpoint: "latest?symbols=ZAR,USD,AUD&base=BTC")
    }

    // Add more methods for other API calls if needed
}

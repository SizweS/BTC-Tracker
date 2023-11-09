//
//  BTCService.swift
//  BTC-Tracker
//
//  Created by Sizwe Maluleke on 2023/11/08.
//

import Combine
import Foundation

class BTCService {
    private let networkManager: NetworkManager
    private let baseUrl = "https://api.apilayer.com/fixer/"
    private let apiKey = "1yJg56aYgDPSAwO5mMhmq7I8AMxje8Zs"
    private let symbols = "ZAR,USD,AUD,BTC"
    private let baseCurrency = "BTC"

    init() {
        self.networkManager = NetworkManager(apiKey: apiKey, baseURL: baseUrl)
    }
    
   private func getYesterdayAndTodayDates() -> (String, String) {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let today = Date()
        
        if let yesterday = calendar.date(byAdding: .day, value: -1, to: today) {
            let todayString = formatter.string(from: today)
            let yesterdayString = formatter.string(from: yesterday)
            return (yesterdayString, todayString)
        }
        
        return ("", "")
    }

    func fetchCurrencyRates() -> AnyPublisher<Currency, Error> {
        return networkManager.fetchData(forEndpoint: "latest?symbols=\(symbols)&base=\(baseCurrency)")
    }
    
    func fetchCurrencyFluctuations() -> AnyPublisher<Fluctuations, Error> {
        let (yesterday, today) = getYesterdayAndTodayDates()
        let endpoint = "fluctuation?start_date=\(yesterday)&end_date=\(today)&symbols=\(symbols)&base=\(baseCurrency)"
        
        return networkManager.fetchData(forEndpoint: endpoint)
    }
    
}

//
//  ListViewViewModel.swift
//  BTC-Tracker
//
//  Created by Sizwe Maluleke on 2023/11/08.
//

import Foundation
import Combine

class CurrencyListViewModel: ObservableObject {
    private let btcService: BTCService
    @Published var currencies: Currency?
    @Published var fluctuations: Fluctuations?

    private var cancellables: Set<AnyCancellable> = []
    
    var investmentViewModel: InvestmentViewModel
    
    // Computed property to calculate converted rates based on Bitcoin amount
    var convertedRates: [String: Double] {
        guard let rates = currencies?.rates else {
            return [:]
        }

        let bitcoinAmount = investmentViewModel.bitcoinAmount
        return rates.mapValues { rate in
            return rate * bitcoinAmount
        }
    }

    init(btcService: BTCService, investmentViewModel: InvestmentViewModel) {
        self.btcService = btcService
        self.investmentViewModel = investmentViewModel
    }

    func fetchCurrencyRates() {
        btcService.fetchCurrencyRates()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("API Request Error: \(error)")
                }
            }, receiveValue: { [weak self] response in
                self?.currencies = response
            })
            .store(in: &cancellables)
    }
    
    func fetchFluctuations() {
        btcService.fetchCurrencyFluctuations()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("API Request Error: \(error)")
                }
            }, receiveValue: { [weak self] response in
                self?.fluctuations = response
            })
            .store(in: &cancellables)
    }

}






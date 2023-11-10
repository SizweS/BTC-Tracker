//
//  BTC_TrackerApp.swift
//  BTC-Tracker
//
//  Created by Sizwe Maluleke on 2023/11/08.
//

import SwiftUI

@main
struct BTC_TrackerApp: App {
    var body: some Scene {
        WindowGroup {
            let btcService = BTCService()
            let investmentViewModel = InvestmentViewModel()
            let currencyListViewModel = CurrencyListViewModel(btcService: btcService, investmentViewModel: investmentViewModel)
            ContentView(currencyListViewModel: currencyListViewModel, investmentViewModel: investmentViewModel)
        }
    }
}


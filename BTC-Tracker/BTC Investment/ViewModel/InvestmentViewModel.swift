//
//  InvestmentViewModel.swift
//  BTC-Tracker
//
//  Created by Sizwe Maluleke on 2023/11/09.
//

import SwiftUI

class InvestmentViewModel: ObservableObject {
    @Published var bitcoinAmount: Double {
        didSet {
            // Store the updated investment amount in UserDefaults
            UserDefaults.standard.set(bitcoinAmount, forKey: "BitcoinAmount")
        }
    }

    init() {
        // Initialize the investment amount from UserDefaults (if available)
        self.bitcoinAmount = UserDefaults.standard.double(forKey: "BitcoinAmount")
    }
}


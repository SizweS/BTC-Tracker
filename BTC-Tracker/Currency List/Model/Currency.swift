//
//  Currency.swift
//  BTC-Tracker
//
//  Created by Sizwe Maluleke on 2023/11/08.
//

import Foundation

struct Currency: Codable {
    let base: String
    let date: String
    let rates: [String: Double]
    let success: Bool
    let timestamp: Int
}

struct Fluctuations: Codable {
    let base: String
    let end_date: String
    let fluctuation: Bool
    let rates: [String: Rate]
    let start_date: String
    let success: Bool
}

struct Rate: Codable {
    let change: Double
    let change_pct: Double
    let end_rate: Double
    let start_rate: Double
}


//
//  Currency.swift
//  BTC-Tracker
//
//  Created by Sizwe Maluleke on 2023/11/08.
//

import Foundation

struct Currency: Decodable, Identifiable, Hashable {
    var base: String?
    var rates: [String: Double]?
}


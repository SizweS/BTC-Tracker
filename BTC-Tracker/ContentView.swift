//
//  ContentView.swift
//  BTC-Tracker
//
//  Created by Sizwe Maluleke on 2023/11/08.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var currencyListViewModel: CurrencyListViewModel
    @ObservedObject var investmentViewModel: InvestmentViewModel

    var body: some View {
        VStack {
            InvestmentView(viewModel: investmentViewModel)
            CurrencyListView(viewModel: currencyListViewModel, investmentViewModel: investmentViewModel)
        }
    }
}




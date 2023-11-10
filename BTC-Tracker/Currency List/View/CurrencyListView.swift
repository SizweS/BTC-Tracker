//
//  CurrencyListView.swift
//  BTC-Tracker
//
//  Created by Sizwe Maluleke on 2023/11/08.
//

import SwiftUI

struct CurrencyListView: View {
    @ObservedObject var viewModel: CurrencyListViewModel
    @ObservedObject var investmentViewModel: InvestmentViewModel

    var body: some View {
            List {
                Section(header: Text("Investment Value").font(.callout)) {
                    ForEach(Array(viewModel.convertedRates.keys.sorted()), id: \.self) { currencyCode in
                        if let convertedRate = viewModel.convertedRates[currencyCode], let fluctuation = viewModel.fluctuations?.rates[currencyCode] {
                            HStack {
                                Image(currencyCode)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                VStack(alignment: .leading){
                                    Text("\(currencyCode)")
                                        .foregroundStyle(.gray)
                                        .font(.caption)
                                    let formattedRate = String(format: "%.4f", convertedRate)
                                    Text("\(formattedRate)")
                                        .bold()
                                }
                                Spacer()
                                let formattedChangePct = String(format: "%.3f", fluctuation.change_pct)
                                Text("\(fluctuation.change_pct >= 0 ? "+\(formattedChangePct)%" : "\(formattedChangePct)%")")
                                        .foregroundColor(fluctuation.change_pct >= 0 ? .green : .red)
                                        .font(.footnote)
                            }
                        }
                    }
                    }
                
            }
            .onAppear {
                viewModel.fetchCurrencyRates()
                viewModel.fetchFluctuations()
            }
    }
}





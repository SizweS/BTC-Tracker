//
//  InvestmentView.swift
//  BTC-Tracker
//
//  Created by Sizwe Maluleke on 2023/11/09.
//

import SwiftUI
import Combine

struct InvestmentView: View {
    @ObservedObject var viewModel: InvestmentViewModel
    @State private var inputValue = ""

    var body: some View {
        VStack {
            VStack {
                Text("\(viewModel.bitcoinAmount)")
                    .font(.largeTitle)
                    .bold()
                Text("BTC investment")
                    .font(.subheadline)
            }
            .padding()
            
            HStack {
                TextField("Enter BTC Amount", text: $inputValue)
                    .keyboardType(.decimalPad)
                    .onReceive(Just(inputValue)) { newValue in
                        let filtered = newValue.filter { "0123456789,.".contains($0) }
                        if filtered != newValue {
                            inputValue = filtered
                        }
                    }
                    .textFieldStyle(.roundedBorder)
                    .cornerRadius(8)
                
                Button(action: {
                    let formatter = NumberFormatter()
                    formatter.locale = Locale.current
                    if let newValue = formatter.number(from: inputValue)?.doubleValue {
                        viewModel.bitcoinAmount = newValue
                    }
                }) {
                    Text("Update")
                        .bold()
                }
                .buttonStyle(.borderedProminent)
                .cornerRadius(8)
            }
            .padding()
        }
        .padding()
    }
}

struct InvestmentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = InvestmentViewModel()
        return InvestmentView(viewModel: viewModel)
    }
}

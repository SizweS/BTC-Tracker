//
//  InvestmentView.swift
//  BTC-Tracker
//
//  Created by Sizwe Maluleke on 2023/11/09.
//

import SwiftUI
import Combine

struct InvestmentView: View {
    @Binding var bitcoinAmount: Double
    @State private var inputValue = ""
    
    var body: some View {
        VStack {
            Text("BTC Investment Amount: \(bitcoinAmount)")
            HStack {
                TextField("Enter Bitcoin Amount", text: $inputValue)
                    .keyboardType(.decimalPad)
                    .onReceive(Just(inputValue)) { newValue in
                        let filtered = newValue.filter { "0123456789.,".contains($0) }
                        if filtered != newValue {
                            inputValue = filtered
                        }
                    }
                Button(action: {
                    let formatter = NumberFormatter()
                    formatter.locale = Locale.current // Use the current locale
                    if let newValue = formatter.number(from: inputValue)?.doubleValue {
                        bitcoinAmount = newValue
                    }
                }) {
                    Text("Update")
                }
            }
        }
    }
}

struct InvestmentView_Previews: PreviewProvider {
    @State static var bitcoinAmount: Double = 0.0

    static var previews: some View {
        InvestmentView(bitcoinAmount: $bitcoinAmount)
    }
}

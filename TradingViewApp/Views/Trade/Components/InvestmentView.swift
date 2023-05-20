//
//  InvestmentView.swift
//  TradingViewApp
//
//  Created by Илья Дубенский on 20.05.2023.
//

import SwiftUI

struct InvestmentView: View {
    @Binding var investment: Int

    var body: some View {
        VStack {
            Text("Investment")
            HStack {
                Button(action: {
                    decreaseAmount()
                }) {
                    Image(systemName: "minus.circle")
                }

                TextField("Amount", value: $investment, formatter: NumberFormatter())
                    .padding(.horizontal)
                    .keyboardType(.numberPad)
                    .submitLabel(.done)
                    .bold()
                

                Button(action: {
                    increaseAmount()
                }) {
                    Image(systemName: "plus.circle")
                }
            }
            .padding(.top, 6)

        }
    }
    
    private func decreaseAmount() {
        if investment > 0 {
            investment -= 100
        }
    }

    private func increaseAmount() {
        investment += 100
    }
}


struct InvestmentView_Previews: PreviewProvider {
    static var previews: some View {
        InvestmentView(investment: .constant(1000))
    }
}

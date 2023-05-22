//
//  InvestmentView.swift
//  TradingViewApp
//
//  Created by Илья Дубенский on 20.05.2023.
//

import SwiftUI

struct InvestmentView: View {
    @Binding var investment: Int
    let balance: Int

    var body: some View {
        VStack {
            Text("Investment")
            HStack {
                Button(action: {
                    decreaseAmount()
                }) {
                    Image(systemName: "minus.circle")
                }

                TextField("Amount", text: Binding<String>(
                    get: { String(investment) },
                    set: {
                        if let value = Int($0) {
                            if value <= balance {
                                investment = value
                            } else {
                                investment = balance
                            }
                        }
                    }
                ))
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
        if investment > 100 {
            investment -= 100
        }
    }

    private func increaseAmount() {
        if balance > investment {
            investment += 100
        } else {
            investment = balance
        }
    }
}


struct InvestmentView_Previews: PreviewProvider {
    static var previews: some View {
        InvestmentView(investment: .constant(1000), balance: 0)
    }
}

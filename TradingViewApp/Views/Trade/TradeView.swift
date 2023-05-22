//
//  TradeView.swift
//  TradingViewApp
//
//  Created by Илья Дубенский on 17.05.2023.
//

import SwiftUI

struct TradeView: View {
    @State private var balance = DataManager.shared.yourBalance
    @State private var currentPair = DataManager.shared.pairs.values.sorted(by: <)[0]
    @State private var investment = DataManager.shared.investmentAmount
    @State private var isSelling = false
    @State private var showResultAlert = false
    @State private var resultAlertMessage = ""
    @State private var isLoading = true
    @State private var remainingSeconds = 0

    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                ScrollView {
                    // MARK: - Balance
                    VStack {
                        Text("Balance")
                            .font(.callout)
                        Text(balance.description)
                            .font(.system(size: 24, weight: .bold))
                    }
                    .padding()
                    .frame(width: Constants.shared.screen.width * 0.93, height: Constants.shared.screen.height * 0.08)
                    .background(Color.gray.opacity(0.3))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)

                    // MARK: - Widget
                    ZStack {
                        if isLoading {
                            ProgressView()
                                .background(Color.clear)
                                .cornerRadius(12)
                                .frame(height: Constants.shared.screen.height * 0.35)
                                .padding(.horizontal)
                        } else {
                            TradingViewWidgetView(selectedCurrency: $currentPair)
                                .background(Color("darkBlue"))
                                .cornerRadius(12)
                                .frame(height: Constants.shared.screen.height * 0.35)
                                .padding(.horizontal)
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            isLoading = false
                        }
                    }

                    // MARK: - Pairs
                    NavigationLink(destination: CurrencyPairView(selectedPair: $currentPair)) {
                        HStack {
                            Spacer()
                            Text(currentPair.0)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(height: Constants.shared.screen.height * 0.08)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)

                    // MARK: - Timer And Investment
                    HStack(spacing: 10) {
                        TimerView(remainingSeconds: $remainingSeconds)
                            .padding()
                            .frame(width: 192, height: Constants.shared.screen.height * 0.1)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(12)
                        InvestmentView(investment: $investment, balance: balance)
                            .padding()
                            .frame(width: 192, height: Constants.shared.screen.height * 0.1)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(12)
                            .frame(height: Constants.shared.screen.height * 0.1)
                    }
                    .padding(.horizontal)
                    .font(.headline)
                    .foregroundColor(.white)

                    // MARK: - Sell And Buy
                    HStack(spacing: 10) {
                        Button(action: sellInvestment) {
                            HStack {
                                VStack {
                                    Text("Sell")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .padding()
                                    Spacer()
                                }
                                Spacer()
                            }
                            .background(balance > 0 ? .red : .gray)
                            .cornerRadius(12)
                        }
                        .disabled(balance < 1)

                        Button(action: sellInvestment) {
                            HStack {
                                VStack {
                                    Text("Buy")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .padding()
                                    Spacer()
                                }
                                Spacer()
                            }
                            .background(balance > 0 ? Color("darkGreen") : .gray)
                            .cornerRadius(12)
                        }
                        .disabled(balance < 1)

                    }
                    .frame(height: Constants.shared.screen.height * 0.1)
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.horizontal)
                }
                .padding()
            }
            .alert(isPresented: $showResultAlert) {
                Alert(
                    title: Text("Result"),
                    message: Text(resultAlertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            .navigationTitle("Trade")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color("darkBlue"), for: .navigationBar)
            .toolbarColorScheme(ColorScheme.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button(action: {
                        self.endEditing()
                    }) {
                        Text("Done")
                            .foregroundColor(.blue)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Text("Investment: \(investment)")
                }
            }
            .onTapGesture {
                self.endEditing()
            }
        }
    }

    private func sellInvestment() {
        let chance = Int.random(in: 1...10) <= 5

        if chance {
            let profit = Double(investment) * 0.7
            balance += Int(profit)
            resultAlertMessage = "Profit: \(Int(profit))"
        } else {
            balance -= investment
            resultAlertMessage = "You lost the investment amount."
        }
        switch balance {
        case (1...1_000):
            investment = 100
        case (1_000...10_000):
            investment = 1_000
        case (10_000...100_000):
            investment = 10_000
        case (100_000...1_000_000):
            investment = 100_000
        case (1_000_000...10_000_000):
            investment = 100_0000
        default:
            investment = 1_000_000
        }
        remainingSeconds = 0
        investment = 1000
        showResultAlert = true
    }

    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}



struct TradeView_Previews: PreviewProvider {
    static var previews: some View {
        TradeView()
    }
}

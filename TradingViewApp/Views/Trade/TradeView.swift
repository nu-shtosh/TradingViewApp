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
                    .frame(width: screen.width * 0.93, height: screen.height * 0.08)
                    .background(Color.gray.opacity(0.3))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)

                    // MARK: - Widget
                    ZStack {
                        if isLoading {
                            ProgressView()
                                .background(Color("darkBlue"))
                                .cornerRadius(12)
                                .frame(height: screen.height * 0.35)
                                .padding(.horizontal)
                        } else {
                            TradingViewWidgetView(selectedCurrency: $currentPair)
                                .background(Color("darkBlue"))
                                .cornerRadius(12)
                                .frame(height: screen.height * 0.35)
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
                        .frame(height: screen.height * 0.08)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)

                    // MARK: - Timer And Investment
                    HStack(spacing: 10) {
                        TimerView(remainingSeconds: $remainingSeconds)
                            .padding()
                            .frame(width: 192, height: screen.height * 0.1)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(12)
                        InvestmentView(investment: $investment)
                            .padding()
                            .frame(width: 192, height: screen.height * 0.1)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(12)
                            .frame(height: screen.height * 0.1)
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
                            .background(.red)
                            .cornerRadius(12)
                        }

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
                            .background(Color("darkGreen"))
                            .cornerRadius(12)
                        }
                    }
                    .frame(height: screen.height * 0.1)
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
                    Text("\(investment)")
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
            resultAlertMessage = "Successfully sold! Profit: \(Int(profit))"
        } else {
            balance -= Int(investment)
            resultAlertMessage = "Sold! You lost the investment amount."
        }

        remainingSeconds = 0
        showResultAlert = true
    }

    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct TradeView_Previews: PreviewProvider {
    static var previews: some View {
        TradeView()
    }
}

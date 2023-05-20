//
//  TopView.swift
//  TradingViewApp
//
//  Created by Илья Дубенский on 17.05.2023.
//

import SwiftUI

struct TopView: View {
    @State private var topTraders = DataManager.shared.traders.sorted { trader1, trader2 in
        trader1.profit > trader2.profit
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text("№")
                            .font(.callout)
                            .frame(width: 30, alignment: .leading)
                            .padding(.leading)
                        Spacer()
                        Text("Сountry")
                            .font(.callout)
                            .frame(width: 60, alignment: .leading)
                        
                        Spacer()
                        Text("Name")
                            .font(.callout)
                            .frame(width: 70, alignment: .leading)
                        
                        Spacer()
                        Text("Deposit")
                            .font(.callout)
                            .frame(width: 90, alignment: .leading)
                        
                        Spacer()
                        Text("Profit")
                            .font(.callout)
                            .frame(width: 70, alignment: .trailing)
                            .padding(.trailing)
                        
                    }
                    .padding()
                    .frame(height: 60)
                    .foregroundColor(.gray)
                    .background(.gray.opacity(0.1))
                    
                    ForEach(0..<topTraders.count) { index in
                        let trader = topTraders[index]
                        HStack(spacing: 0) {
                            Text("\(index + 1)")
                                .frame(width: 20, alignment: .leading)
                                .foregroundColor(.white)
                            Spacer()
                            Text(trader.country)
                                .frame(width: 40, alignment: .leading)
                            Spacer()
                            Text(trader.name)
                                .foregroundColor(.white)
                                .bold()
                                .frame(width: 80, alignment: .leading)
                            Spacer()
                            Text("$\(trader.deposit)")
                                .foregroundColor(.white)
                                .frame(width: 70, alignment: .leading)
                            Spacer()
                            
                            Text("$\(trader.profit)")
                                .frame(width: 100, alignment: .trailing)
                                .foregroundColor(.green)
                                .padding(.trailing)
                        }
                        .padding(.leading)
                        .frame(height: 60)
                        .background(index % 2 != 0 ? .gray.opacity(0.1) : .black.opacity(0.1))
                    }
                    .onAppear {
                        updateTraders()
                    }
                }
                .frame(width: screen.width * 0.9)
                .cornerRadius(16)
            }
            .navigationTitle("Top 10 Traders")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color("darkBlue"), for: .navigationBar)
            .toolbarColorScheme(ColorScheme.dark, for: .navigationBar)
        }
    }
    
    func updateTraders() {
        let timer = Timer.scheduledTimer(withTimeInterval: 180, repeats: true) { _ in
            DispatchQueue.main.async {
                if let randomIndex = topTraders.indices.randomElement() {
                    let randomDelta = Int.random(in: 50...150)
                    topTraders[randomIndex].deposit += randomDelta
                    topTraders[randomIndex].profit += randomDelta
                }
            }
        }
        timer.fire()
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}

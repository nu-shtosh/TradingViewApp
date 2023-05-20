//
//  CurrencyPairView.swift
//  TradingViewApp
//
//  Created by Илья Дубенский on 18.05.2023.
//

import SwiftUI

struct CurrencyPairView: View {
    @Binding var selectedPair: (String, String)
    @State private var allPairs = DataManager.shared.pairs
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            BackgroundView()
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(allPairs.keys.sorted(), id: \.self) { key in
                    Button(action: {
                        selectedPair = allPairs[key]!
                        presentationMode.wrappedValue.dismiss()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Text(allPairs[key]!.0)
                            .padding()
                            .frame(width: screen.width * 0.4, height: screen.height * 0.07)
                            .background(Color.gray.opacity(0.3))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .padding(8)
                    }
                }
            }
        }
        .navigationTitle("Currency Pairs")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color("darkBlue"), for: .navigationBar)
        .toolbarColorScheme(ColorScheme.dark, for: .navigationBar)
    }
}

struct CurrencyPairView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyPairView(selectedPair: .constant(("", "")))
    }
}

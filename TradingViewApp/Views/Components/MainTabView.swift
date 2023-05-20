//
//  ContentView.swift
//  TradingViewApp
//
//  Created by Илья Дубенский on 17.05.2023.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0

    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color("darkBlue"))
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    }

    var body: some View {
        TabView {
            TopView()
                .tabItem {
                    VStack {
                        Text("Top")
                        Image(systemName: "chart.bar.fill")
                    }
                }
                .tag(0)
            TradeView()
                .tabItem {
                    VStack {
                        Text("Trade")
                        Image(systemName: "dollarsign.square.fill")
                            .background(.white)
                            .foregroundColor(.white)
                            .tint(.white)
                    }
                }
                .tag(1)
        }
        .tint(Color("darkGreen"))
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarColorScheme(.dark, for: .tabBar)
    }
}


struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}


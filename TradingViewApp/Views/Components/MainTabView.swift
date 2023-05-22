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

        requestNotificationPermission()
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

    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Ошибка при запросе разрешения уведомлений: \(error.localizedDescription)")
            } else if granted {
                print("Разрешение на уведомления получено")
            } else {
                print("Разрешение на уведомления не получено")
            }
        }
    }
}


struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}


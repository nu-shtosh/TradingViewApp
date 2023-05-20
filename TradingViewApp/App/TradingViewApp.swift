//
//  TradingViewAppApp.swift
//  TradingViewApp
//
//  Created by Илья Дубенский on 17.05.2023.
//

import SwiftUI
import UserNotifications

let screen = UIScreen.main.bounds

@main
struct TradingViewApp: App {
    var body: some Scene {
        WindowGroup {
            LoadingView()
        }
    }

    private func requestNotificationAuthorization() {
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


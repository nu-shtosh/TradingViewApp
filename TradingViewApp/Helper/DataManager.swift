//
//  DataManager.swift
//  TradingViewApp
//
//  Created by Илья Дубенский on 17.05.2023.
//

import Foundation

class DataManager {
    static let shared: DataManager = .init()

    let traders = [Trader(deposit: 999, name: "Oliver", country: "🇦🇹", profit: 124244),
                   Trader(deposit: 777, name: "Jack", country: "🇧🇬", profit: 1243412),
                   Trader(deposit: 330, name: "Harry", country: "🇧🇯", profit: 324211),
                   Trader(deposit: 215, name: "Jacob", country: "🏳️‍🌈", profit: 236232),
                   Trader(deposit: 200, name: "Charley", country: "🇻🇬", profit: 223553),
                   Trader(deposit: 100, name: "Thomas", country: "🇮🇴", profit: 351125),
                   Trader(deposit: 1000, name: "George", country: "🏴󠁧󠁢󠁳󠁣󠁴󠁿", profit: 215551),
                   Trader(deposit: 800, name: "Oscar", country: "🇬🇹", profit: 21451255),
                   Trader(deposit: 1230, name: "James", country: "🇬🇳", profit: 4000_50),
                   Trader(deposit: 3000, name: "William", country: "🏴‍☠️", profit: 20000_00)]

    let yourBalance = 10000

    let investmentAmount = 1000

    let pairs = ["EURUSD": ("EUR / USD", "FX:EURUSD"),
                 "GBPUSD": ("GPB / USD", "FX:GBPUSD"),
                 "USDJPY": ("USD / JPY", "FX:USDJPY"),
                 "GBPJPY": ("GBP / JPY", "FX:GBPJPY"),
                 "AUDUSD": ("AUD / USD", "FX:AUDUSD"),
                 "USDCAD": ("USD / CAD", "FX:USDCAD"),
                 "EURJPY": ("EUR / JPY", "FX:EURJPY"),
                 "USDCHF": ("USD / CHF", "FX:USDCHF"),
                 "NZDUSD": ("NZD / USD", "FX:NZDUSD"),
                 "AUDJPY": ("AUD / JPY", "FX:AUDJPY"),
                 "EURGBP": ("EUR / GBP", "FX:EURGBP"),
                 "EURAUD": ("EUR / AUD", "FX:EURAUD"),
                 "CADJPY": ("CAD / JPY", "FX:CADJPY"),
                 "GBPAUD": ("GBP / AUD", "FX:GBPAUD")]
}

//
//  Extensions.swift
//  TradingViewApp
//
//  Created by Илья Дубенский on 22.05.2023.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

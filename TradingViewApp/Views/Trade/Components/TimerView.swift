//
//  TimerView.swift
//  TradingViewApp
//
//  Created by Илья Дубенский on 20.05.2023.
//

import SwiftUI

struct TimerView: View {
    @Binding var remainingSeconds: Int

    var body: some View {
        VStack {
            Text("Timer")
            HStack {
                Button(action: {
                    decreaseTime()
                }) {
                    Image(systemName: "minus.circle")
                }
                Text("\(formattedTime(remainingSeconds))")
                    .padding(.horizontal)
                    .bold()


                Button(action: {
                    increaseTime()
                }) {
                    Image(systemName: "plus.circle")
                }
            }
            .padding(.top, 6)
        }
    }

    private func decreaseTime() {
        if remainingSeconds > 0 {
            remainingSeconds -= 1
        }
    }

    private func increaseTime() {
        remainingSeconds += 1
    }

    private func formattedTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}


struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(remainingSeconds: .constant(0))
    }
}

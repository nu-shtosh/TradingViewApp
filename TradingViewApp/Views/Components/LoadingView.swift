//
//  LoadingView.swift
//  TradingViewApp
//
//  Created by Илья Дубенский on 17.05.2023.
//

import SwiftUI

struct LoadingView: View {
    @State private var progress: CGFloat = 0.0
    @State private var isLoadingComplete = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                Spacer()
                
                ProgressView(value: progress, total: 100)
                    .progressViewStyle(LinearProgressViewStyle())
                    .accentColor(Color("darkGreen"))
                    .frame(width: 300, height: 20)
                    .scaleEffect(CGSize(width: 1, height: 12))
                    .cornerRadius(12)
                    .overlay(Text("\(Int(progress))%")
                        .foregroundColor(.white))
                    .onAppear {
                        simulateProgress()
                    }
                    .fullScreenCover(isPresented: $isLoadingComplete) {
                        MainTabView()
                    }
                
                Spacer()
            }
        }
    }
    
    private func simulateProgress() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            for value in stride(from: 0, through: 100, by: 1) {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(value) * 0.03) {
                    progress = CGFloat(value)
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.1) {
                isLoadingComplete = true
            }
        }
    }
}


struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

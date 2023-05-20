//
//  BackgroundView.swift
//  TradingViewApp
//
//  Created by Илья Дубенский on 17.05.2023.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack {
            Color("darkBlue")
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.red)
                        .frame(width: 120, height: 120)
                        .padding(.trailing, 30)
                    
                }
                
                Spacer(minLength: 300)
                
                
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.green)
                        .frame(width: 120, height: 120)
                        .padding(.leading, 30)
                    Spacer()
                    
                }
                Spacer()
                
            }
            .blur(radius: 70)
        }
    }
}


struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}

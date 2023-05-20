//
//  TradingViewWidgetView.swift
//  TradingViewApp
//
//  Created by Илья Дубенский on 20.05.2023.
//

import SwiftUI
import WebKit

struct TradingViewWidgetView: UIViewRepresentable {
    @Binding var selectedCurrency: (String, String)
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let htmlString = """
        <html>
        <head>
        <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
        </head>
        <div class="tradingview-widget-container">
            <div id="tradingview_a9d18"></div>
            <script type="text/javascript">
            new TradingView.widget(
        {
        "autosize": true,
        "symbol": "\(selectedCurrency.1)",
        "interval": "D",
        "timezone": "Etc/UTC",
        "theme": "light",
        "style": "1",
        "locale": "en",
        "toolbar_bg": "#f1f3f6",
        "enable_publishing": false,
        "allow_symbol_change": true,
        "container_id": "tradingview_80ff7"
        }
            );
            </script>
        </div>
        </html>
        """
        
        uiView.loadHTMLString(htmlString, baseURL: nil)
    }
}

struct TradingViewWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        TradingViewWidgetView(selectedCurrency: .constant(("","")))
    }
}

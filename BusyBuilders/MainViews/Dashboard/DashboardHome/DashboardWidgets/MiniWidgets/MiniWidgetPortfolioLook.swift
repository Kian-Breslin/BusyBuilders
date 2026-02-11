//
//  MiniWidgetPortfolioLook.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 13/08/2025.
//

import SwiftUI
import SwiftData
import Charts

struct MiniWidgetPortfolioLook: View {
    @EnvironmentObject var userManager: UserManager
    let widgetSize = miniWidgetSize
    let stockData = [
        StockHolding(name: "AAPL", value: 3000, opacity: 0.25),
        StockHolding(name: "GOOGL", value: 2500, opacity: 0.5),
        StockHolding(name: "TSLA", value: 1500, opacity: 0.75),
        StockHolding(name: "MSFT", value: 2000, opacity: 1)
    ]
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
           .frame(width: widgetSize.width, height: widgetSize.height)
           .foregroundStyle(userManager.mainColor)
           .overlay {
               Chart(stockData, id: \.name) { stock in
                   SectorMark(
                       angle: .value("Value", stock.value),
                       innerRadius: .ratio(0.3)
                   )
                   .foregroundStyle(getColor(userManager.accentColor).opacity(stock.opacity))
               }
               .chartLegend(.hidden)
               .frame(width: min(widgetSize.width * 0.8, widgetSize.height * 0.8))
           }
    }
}

struct StockHolding {
    let name: String
    let value: Double
    let opacity: Double
}

#Preview {
    MiniWidgetPortfolioLook()
        .environmentObject(UserManager())
}

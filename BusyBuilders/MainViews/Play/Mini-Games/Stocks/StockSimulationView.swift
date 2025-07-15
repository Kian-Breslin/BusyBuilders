//
//  StockSimulationView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 15/07/2025.
//

import SwiftUI
import SwiftData

struct StockSimulationView: View {
    @EnvironmentObject var themeManager : ThemeManager
    @Binding var isGameOver: Bool
    @State var business : mockBusinesses
    @Binding var stocksBought : Int
    @Binding var stockPrice : Double
    
    var body: some View {
        ZStack {
            themeManager.mainColor.ignoresSafeArea()
            VStack (alignment: .leading){
                VStack (alignment: .leading){
                    Text("\(business.name)")
                        .font(.system(size: 35))
                    Text("Starting Price: $\(business.currentStockPrice, specifier: "%.f")")
                    Text("Stocks Bought: \(stocksBought)")
                }
                .font(.system(size: 25))
                Spacer()
                
                StockSimulationGame(isGameOver: $isGameOver, price: $stockPrice, stockPrice: [stockPrice], stocksBought: stocksBought)
                
                Spacer()
            }
            .frame(width: screenWidth-20, alignment: .leading)
            .foregroundStyle(themeManager.textColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

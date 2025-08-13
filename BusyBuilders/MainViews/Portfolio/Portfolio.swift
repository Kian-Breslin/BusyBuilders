//
//  Portfolio.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 17/07/2025.
//

import SwiftUI
import SwiftData

struct Portfolio: View {
    @EnvironmentObject var userManager: UserManager
    @State var selectedIcon = "book.pages"
    
    var body: some View {
        VStack {
            TopNavigation(
                title: "Portfolio",
                iconNames: ["book.pages", "building.2", "circle", "building.columns"],
                iconLabels: ["My Stats", "Businesses", "Stocks", "City"],
                selectedIcon: $selectedIcon
            )
            Spacer()
        }
        .background(userManager.mainColor)
        
        VStack {
            if selectedIcon == "book.pages" {
                PortfolioMyStats()
            } else if selectedIcon == "building.2" {
                PortfolioBusinesses()
            } else if selectedIcon == "circle" {
                PortfolioStocks()
            }
            else if selectedIcon == "building.columns" {
                
            }
        }
        .background(userManager.mainColor)
    }
}

#Preview {
    Portfolio()
        .environmentObject(UserManager())
}

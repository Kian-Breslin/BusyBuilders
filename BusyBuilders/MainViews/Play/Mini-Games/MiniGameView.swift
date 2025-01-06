//
//  MiniGameView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 26/11/2024.
//

import SwiftUI

struct MiniGameView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var isTaskActive : Bool
    
    var body: some View {
            VStack {
                HStack (spacing: 5){
                    NavigationLink(destination: HigherOrLower(isTaskActive: $isTaskActive)){
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: (screenWidth-15)/2, height: 100)
                            .foregroundStyle(themeManager.mainColor)
                            .overlay {
                                Text("Higher or Lower")
                                    .foregroundStyle(themeManager.textColor)
                            }
                    }

                    NavigationLink(destination: Slots(isTaskActive: $isTaskActive)){
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: (screenWidth-15)/2, height: 100)
                            .foregroundStyle(themeManager.mainColor)
                            .overlay {
                                Text("Slots")
                                    .foregroundStyle(themeManager.textColor)
                            }
                    }
                }
                HStack (spacing: 5){
                    NavigationLink(destination: Stocks(isTaskActive: $isTaskActive, selectedBusiness: mockBusinesses(id: UUID(), name: "", businessLogo: "", industry: "", currentStockPrice: 0.0, volatilityRating: .low))){
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: (screenWidth-15)/2, height: 100)
                            .overlay {
                                Text("Stocks")
                                    .foregroundStyle(themeManager.textColor)
                            }
                    }
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: (screenWidth-15)/2, height: 100)
                }
            }
            .foregroundStyle(themeManager.mainColor)
            .onAppear {
                isTaskActive = false
            }
    }
}

#Preview {
    MiniGameView(isTaskActive: .constant(false))
        .environmentObject(ThemeManager())
}

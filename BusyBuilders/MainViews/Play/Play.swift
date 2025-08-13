//
//  Play.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 17/07/2025.
//

import SwiftUI
import SwiftData

struct Play: View {
    @EnvironmentObject var userManager: UserManager
    @State var selectedIcon = "stopwatch"
    
    var body: some View {
        VStack {
            TopNavigation(
                title: "Play",
                iconNames: ["stopwatch", "book", "gamecontroller", "circle"],
                iconLabels: ["Timer", "Study", "Games", "Stocks"],
                selectedIcon: $selectedIcon
            )
            Spacer()
        }
        .background(userManager.mainColor)
        
        VStack {
            if selectedIcon == "stopwatch" {
                PlayTimer()
            } else if selectedIcon == "book" {
                
            } else if selectedIcon == "gamecontroller" {
                PlayGames()
            }
            else if selectedIcon == "circle" {
                PlayStocks()
            }
        }
        .background(userManager.mainColor)
    }
}

#Preview {
    Play()
        .environmentObject(UserManager())
}

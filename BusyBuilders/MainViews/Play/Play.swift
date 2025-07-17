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
                iconNames: ["stopwatch", "book", "gamecontroller", "chart.line.uptrend.xyaxis"],
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
                
            }
            else if selectedIcon == "chart.line.uptrend.xyaxis" {
                
            }
        }
        .background(userManager.mainColor)
    }
}

#Preview {
    Play()
        .environmentObject(UserManager())
}

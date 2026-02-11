//
//  PlayGames.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 18/07/2025.
//

import SwiftUI
import SwiftData

struct PlayGames: View {
    @EnvironmentObject var userManager: UserManager
    
    @State var isPlayCVSwiper = false
    @State var isPlayOfficeSorter = false
    @State var isPlayStockWatcher = false
    @State var isClockOutRace = false
    var body: some View {
        ScrollView {
            VStack {
                Button("Play CV Swiper") {
                    isPlayCVSwiper.toggle()
                }
                
                customButton(text: "Office Sorter", color: .blue, width: 150, height: 40) {
                    isPlayOfficeSorter.toggle()
                }
                
                customButton(text: "Stock Watcher", color: .red, width: 150, height: 40) {
                    isPlayStockWatcher.toggle()
                }
                
                customButton(text: "Clock Out Race", color: .red, width: 150, height: 40) {
                    isClockOutRace.toggle()
                }
            }
        }
        .scrollIndicators(.hidden)
        .padding(.top, 15)
        .frame(width: screenWidth, height: screenHeight-240)
        .background(userManager.secondaryColor)
        .foregroundStyle(userManager.mainColor)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .fullScreenCover(isPresented: $isPlayCVSwiper) {
            CVSwiper()
        }
        .fullScreenCover(isPresented: $isPlayStockWatcher) {
            StockWatcher()
        }
        .fullScreenCover(isPresented: $isClockOutRace) {
            ClockOutRace()
        }
//        .fullScreenCover(isPresented: $isPlayOfficeSorter) {
//            OfficeSorter()
//        }
    }
}

#Preview {
    Play(selectedIcon: "gamecontroller")
        .environmentObject(UserManager())
}

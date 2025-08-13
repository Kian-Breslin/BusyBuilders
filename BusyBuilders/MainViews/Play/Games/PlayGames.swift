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
    var body: some View {
        ScrollView {
            VStack {
                Button("Play CV Swiper") {
                    isPlayCVSwiper.toggle()
                }
                
                customButton(text: "Office Sorter", color: .blue, width: 150, height: 40) {
                    isPlayOfficeSorter.toggle()
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
//        .fullScreenCover(isPresented: $isPlayOfficeSorter) {
//            OfficeSorter()
//        }
    }
}

#Preview {
    Play(selectedIcon: "gamecontroller")
        .environmentObject(UserManager())
}

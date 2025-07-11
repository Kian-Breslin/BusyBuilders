//
//  MiniGameView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 26/11/2024.
//

import SwiftUI
import SwiftData

struct MiniGameView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var isTaskActive : Bool
    @Query var users: [UserDataModel]
    
    @State var minigameHL = false
    @State var minigameSlots = false

    @State var animateButtonShake = false
    @State var showTokenAlert = false
    
    var body: some View {
            VStack {
                
                Text("Current Tokens: \(users.first?.tokens ?? 0)")
                    .font(.system(size: 30))
                HStack (spacing: 5){
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: (screenWidth-15)/2, height: 100)
                        .foregroundStyle(themeManager.mainColor)
                        .overlay {
                            Text("Higher or Lower")
                                .foregroundStyle(themeManager.textColor)
                        }
                        .animation(.linear, value: animateButtonShake)
                        .onTapGesture {
                            if let user = users.first {
                                if user.tokens > 0 {
                                    minigameHL.toggle()
                                } else {
                                    showTokenAlert = true
                                }
                            }
                        }

                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: (screenWidth-15)/2, height: 100)
                        .foregroundStyle(themeManager.mainColor)
                        .overlay {
                            Text("Slots")
                                .foregroundStyle(themeManager.textColor)
                        }
                        .onTapGesture {
                            if let user = users.first {
                                if user.tokens > 0 {
                                    minigameSlots.toggle()
                                } else {
                                    showTokenAlert = true
                                }
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
            .alert("Not Enough Tokens", isPresented: $showTokenAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("You need at least 1 token to play this minigame.")
            }
            .fullScreenCover(isPresented: $minigameHL) {
                HigherOrLower(isTaskActive: $isTaskActive)
            }
            .fullScreenCover(isPresented: $minigameSlots) {
                Slots(isTaskActive: $isTaskActive)
            }
    }
}

#Preview {
    MiniGameView(isTaskActive: .constant(false))
        .environmentObject(ThemeManager())
}

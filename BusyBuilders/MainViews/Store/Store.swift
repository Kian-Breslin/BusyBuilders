//
//  Store.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 15/10/2024.
//

import SwiftUI
import SwiftData

struct Store: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @Environment(\.modelContext) var context
    @Query var users: [UserDataModel]
    @Query var businesses: [BusinessDataModel]
    
    
    let upgrades = availableUpgrades
    @State private var selectedUpgrade = ""
    @State private var growOnAppear = false
    @State private var selectedScreen = "wrench.and.screwdriver"
    
    let buttonImages: [String] = ["wrench.and.screwdriver", "paintbrush", "gift", "tag"]
    let buttonText: [String] = ["Upgrades", "Cosmetics", "Packs", "Specials"]
    let iconSelectionArray: [String] = ["banknote", "star", "bag.badge.minus", "mug"]
    
    var body: some View {
        ZStack {
            themeManager.mainColor
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    // Top Header
                    HStack {
                        Text("Store")
                            .font(.system(size: 35))
                            .fontWeight(.bold)
                        Spacer()
                        HStack (spacing: 15){
                            ZStack {
                                Image(systemName: "bell.fill")
                                Image(systemName: "2.circle.fill")
                                    .font(.system(size: 15))
                                    .offset(x: 10, y: -10)
                                    .onTapGesture {
                                        
                                    }
                            }
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 40, height: 40)
                                .overlay(content: {
                                    Image("userImage-2")
                                        .resizable()
                                        .frame(width: 40,height: 40)
                                })
                                .onTapGesture {
                                    
                                }
                        }
                        .font(.system(size: 25))
                    }
                    .frame(width: screenWidth-30, height: 60)
                    .foregroundStyle(themeManager.textColor)
                    
                    HStack {
                        ForEach(0..<4){ i in
                            VStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 60, height: 60)
                                    .foregroundStyle(themeManager.textColor)
                                    .overlay {
                                        Image(systemName: buttonImages[i] == selectedScreen ? "\(buttonImages[i]).fill" : "\(buttonImages[i])")
                                            .font(.system(size: 30))
                                            .foregroundStyle(themeManager.mainColor)
                                            
                                    }
                                    .onTapGesture {
                                        selectedScreen = buttonImages[i]
                                    }
                                Text(buttonText[i])
                                    .font(.system(size: 10))
                                    .scaledToFit()
                            }
                            .frame(width: 60, height: 80)
                            
                            if i < 3 {
                                Spacer()
                            }
                        }
                    }
                    .font(.system(size: 12))
                    .foregroundStyle(themeManager.textColor)
                    .frame(width: screenWidth-30, height: 100)
                }
                .frame(width: screenWidth-30, height: 160)
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: screenWidth)
                    .foregroundStyle(themeManager.textColor)
                    .overlay {
                        if selectedScreen == "wrench.and.screwdriver" {
                            UpgradesStoreView()
                        }
                    }
            }
        }
    }
}



#Preview {
    Store()
        .environmentObject(ThemeManager())
        .environmentObject(UserManager())
}

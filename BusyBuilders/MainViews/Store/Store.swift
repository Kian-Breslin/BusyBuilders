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
                                .foregroundStyle(themeManager.isDarkMode ? Color.gray.opacity(0.5) : Color(red: 0.8, green: 0.8, blue: 0.8))
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
                    .frame(width: screenWidth-20, height: 60)
                    .foregroundStyle(themeManager.textColor)
                    
                    HStack {
                        ForEach(0..<4){ i in
                            VStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 60, height: 60)
                                    .foregroundStyle(themeManager.isDarkMode ? Color.gray.opacity(0.5) : Color(red: 0.8, green: 0.8, blue: 0.8))
                                    .overlay {
                                        Image(systemName: buttonImages[i] == selectedScreen ? "\(buttonImages[i]).fill" : "\(buttonImages[i])")
                                            .font(.system(size: 30))
                                            .foregroundStyle(themeManager.textColor)
                                            
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
                    .frame(width: screenWidth-20, height: 100)
                }
                .frame(width: screenWidth-20, height: 160)
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: screenWidth)
                    .foregroundStyle(themeManager.isDarkMode ? Color.gray.opacity(0.5) : Color(red: 0.8, green: 0.8, blue: 0.8))
                    .overlay {
                        if selectedScreen == "wrench.and.screwdriver" {
                            VStack (alignment: .leading){
                                Text("Current Balance :")
                                    .padding(.top, 10)
                                    .bold()
                                if let user = users.first {
                                    Text("$\(user.netWorth)")
                                        .font(.system(size: 30))
                                }
                                else {
                                    Text("$4,000,000")
                                        .font(.system(size: 30))
                                }
                                UpgradesStoreView()
                                Spacer()
                            }
                            .foregroundStyle(themeManager.textColor)
                            .font(.system(size: 25))
                        }
                    }
            }
        }
        .onAppear {
            print(users.first?.netWorth ?? "No")
        }
    }
}



#Preview {
    Store()
        .environmentObject(ThemeManager())
        .environmentObject(UserManager())
}

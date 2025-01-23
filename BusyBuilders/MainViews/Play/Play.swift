//
//  Play.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 20/11/2024.
//

import SwiftUI
import SwiftData

struct Play: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Query var businesses: [BusinessDataModel]
    @Query var users : [UserDataModel]
    // Testing
    let newBusiness = BusinessDataModel(businessName: "Cozy Coffee", businessTheme: "pink", businessType: "Eco-Friendly", businessIcon: "circle")
    
    @State var selectedBusiness : BusinessDataModel?
    
    @Binding var isTimerActive : Bool
    @Binding var isTaskActive : Bool
    
    // Modifiers
    @State var isCashBoosterActive = false
    @State var isCostReductionActive = false
    @State var isXPBoosterActive = false
    @State var showInventory = false
    @State var timeSelected = 0
    
    @State var Title = "Play"
    @State var buttonImages = ["stopwatch", "clipboard", "gamecontroller", "archivebox"]
    @State var buttonText = ["Timer", "Flashcards", "Mini-Games", "Inventory"]
    @State var selectedScreen = "stopwatch"
    
    var body: some View {
        NavigationStack {
            ZStack {
                themeManager.mainColor
                    .ignoresSafeArea()
                
                VStack {
                    VStack {
                        // Top Header
                        HStack {
                            Text(Title)
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
                                    .foregroundStyle(themeManager.isDarkMode ? Color.gray.opacity(0.5) : getColor("white"))
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
                            ForEach(0..<4) { i in
                                VStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 60, height: 60)
                                        .foregroundStyle(themeManager.isDarkMode ? Color.gray.opacity(0.5) : getColor("white"))
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
                                
                                // Add a spacer after each VStack, except for the last one
                                if i < 3 {
                                    Spacer()
                                }
                            }
                        }
                        .font(.system(size: 12))
                        .foregroundStyle(themeManager.textColor)
                        .frame(width: screenWidth - 30, height: 100)
                    }
                    .frame(width: screenWidth-20, height: 160)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: screenWidth)
                        .foregroundStyle(themeManager.isDarkMode ? getColor(themeManager.mainDark) : getColor("white"))
                        .overlay {
                            if selectedScreen == "stopwatch" {
//                                TimerConfig(isTimerActive: $isTimerActive)
                                TimerConfig_V2()
                                    .padding(.top, 10)
                            }
                            else if selectedScreen == "clipboard" {
                                DashboardFlashcardView()
                                .padding(.bottom, 45)
                                .padding(.top, 10)
                            }
                            else if selectedScreen == "gamecontroller" {
                                MiniGameView(isTaskActive: $isTaskActive)
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    Play(isTimerActive: .constant(false), isTaskActive: .constant(false))
        .modelContainer(for: UserDataModel.self)
        .environmentObject(ThemeManager())
}

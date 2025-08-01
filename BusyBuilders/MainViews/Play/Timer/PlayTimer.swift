//
//  PlayTimer.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 17/07/2025.
//

import SwiftUI
import SwiftData

struct PlayTimer: View {
    @EnvironmentObject var userManager: UserManager
    @Query var users: [UserDataModel]
    @State private var isTimerActive = false
    @State private var selectedTimer = "Beach"
    
    private let timers = [
        ("Beach", "Beach"),
        ("GrayMountain", "Sunset"),
        ("RedMountain", "Red Mountain"),
        ("Lighthouse", "Lighthouse")
    ]
    
    var body: some View {
        VStack {
            ForEach(timers, id: \.0) { timerKey, timerName in
                customButton(text: timerName, color: selectedTimer == timerKey ? getColor(userManager.accentColor) : .black, width: 150, height: 50, action: {
                    withAnimation(.linear){
                        selectedTimer = timerKey
                    }
                })
                .animation(.easeInOut, value: selectedTimer)
                .padding(.horizontal)
            }
            
            Image("\(selectedTimer)BB")
                .resizable()
                .frame(width: 100, height: 200)
                .transition(.slide)
            Spacer()
            customButton(text: "Start", color: .white, width: 150, height: 50, action: {
                isTimerActive.toggle()
            })
        }
        .padding(.top, 15)
        .frame(width: screenWidth, height: screenHeight - 240)
        .background(userManager.secondaryColor)
        .foregroundColor(userManager.mainColor)
        .fullScreenCover(isPresented: $isTimerActive) {
            switch selectedTimer {
            case "Beach":
                BeachViewTimer(isTimerActive: $isTimerActive)
            case "Sunset":
                TimerSunset()
            case "RedMountain":
                RedMountainTimer()
            case "Lighthouse":
                TimerLighthouse()
            default:
                EmptyView()
            }
        }
    }
}

#Preview {
    Play()
        .environmentObject(UserManager())
}

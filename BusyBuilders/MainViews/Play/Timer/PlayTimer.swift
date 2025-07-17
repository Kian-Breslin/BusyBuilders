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
    @Query var users : [UserDataModel]
    @State var isTimerActive = false
    @State var selectedTimer = "Beach"
    var body: some View {
        ScrollView {
            VStack {
                Button("Beach Timer - \(users.first?.businesses.count ?? 99)") {
                    selectedTimer = "Beach"
                }
                .frame(width: 150, height: 80)
                .background(selectedTimer == "Beach" ? .green : .red)
                .foregroundStyle(.white)
                
                Button("Sunset Timer - \(users.first?.businesses.count ?? 99)") {
                    selectedTimer = "Sunset"
                }
                .frame(width: 150, height: 80)
                .background(selectedTimer == "Sunset" ? .green : .red)
                .foregroundStyle(.white)
                
                Button("Start Timer") {
                    isTimerActive.toggle()
                }
                .frame(width: 150, height: 80)
                .background(userManager.textColor)
                .foregroundStyle(.black)
            }
        }
        .scrollIndicators(.hidden)
        .padding(.top, 15)
        .frame(width: screenWidth, height: screenHeight-240)
        .background(userManager.secondaryColor)
        .foregroundStyle(userManager.mainColor)
        .fullScreenCover(isPresented: $isTimerActive) {
            if selectedTimer == "Beach" {
                BeachViewTimer(isTimerActive: $isTimerActive)
            } else if selectedTimer == "Sunset" {
                TimerSunset(isTimerActive: $isTimerActive)
            }
        }
    }
}

#Preview {
    Play()
        .environmentObject(UserManager())
}

//
//  TimerLighthouse.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 01/08/2025.
//

import SwiftUI
import SwiftData

struct TimerLighthouse: View {
    @EnvironmentObject var userManager: UserManager
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.dismiss) var dismiss
    @Query var users : [UserDataModel]
    
    @StateObject var timerManager = TimerManager()
    
    @State var showSessionStats = false
    
    @State private var sessionStats: SessionDataModel? = nil
    
    @State var showOptions = false
    
    var body: some View {
        ZStack {
            Image("LighthouseBB")
                .resizable()
                .ignoresSafeArea()
            
            VStack (alignment: .leading, spacing: 5){
                Text(formatTime(Date()))
                    .font(.londrina(size: 60))
//                    .font(.system(size: 60))
                Text(formatLongDate(Date()))
                Label("22", systemImage: "cloud.sun")
                
                HStack {
                    Image(systemName: "\(timerManager.isRunning ? "pause" : "play")")
                        .onTapGesture {
                            if timerManager.isRunning == true {
                                timerManager.pause()
                            } else {
                                timerManager.start()
                            }
                        }
                    
                    Image(systemName: "eye")
                        .onTapGesture {
                            withAnimation(.bouncy){
                                showOptions.toggle()
                            }
                        }
                }
                .padding(.top, 5)
                Spacer()
                
                if showOptions {
                    HStack {
                        Label("\(secondsToMinutes(seconds: timerManager.timeElapsed))", systemImage: "clock")
                            .font(.system(size: 40))
                        Spacer()
                        customImageButton(image: "xmark", color: .white, width: 50, height: 50) {
                            DispatchQueue.main.async {
                                if let user = users.first {
                                    let newSession = user.MakeSession(time: timerManager.timeElapsed)
                                    sessionStats = newSession
                                    user.availableBalance += newSession.total
                                    showSessionStats.toggle()
                                }
                            }
                        }
                        customImageButton(image: "toilet", color: .white, width: 50, height: 50) {
                            
                        }
                    }
                    .padding()
                    .transition(.move(edge: .leading))
                }
            }
            .foregroundStyle(.white)
            .frame(width: screenWidth-20, alignment: .leading)
        }
        .onAppear {
            timerManager.start()
        }
        .sheet(isPresented: $showSessionStats, content: {
            if let sessionStats = sessionStats {
                TimerEndScreen(sessionStats: sessionStats)
                    .presentationDetents([.fraction(0.7)])
                    .onDisappear {
                        dismiss()
                    }
            } else {
                Text("No session data available.")
            }
        })
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                timerManager.start()
            } else {
                timerManager.pause()
            }
        }
    }
}

#Preview {
    TimerLighthouse()
        .environmentObject(UserManager())
}

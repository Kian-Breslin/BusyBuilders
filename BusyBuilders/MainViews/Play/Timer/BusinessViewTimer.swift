//
//  BusinessViewTimer.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 14/07/2025.
//

import SwiftUI
import SwiftData

struct BusinessViewTimer: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.dismiss) var dismiss
    @Query var users : [UserDataModel]
    @State var business : BusinessDataModel
    
    @StateObject var timerManager = TimerManager()
    @Binding var isTimerActive : Bool
    
    @State var showSessionStats = false
    
    var body: some View {
        ZStack {
            themeManager.mainColor.ignoresSafeArea()
            VStack(spacing: 20) {
                
                Button("Close") {
                    dismiss()
                }
                Text("Time: \(timerManager.timeElapsed) seconds")
                    .font(.title)
                    .foregroundColor(.white)
                
                Button(action: {
                    if timerManager.isRunning {
                        timerManager.pause()
                    } else {
                        timerManager.start()
                    }
                }) {
                    Text(timerManager.isRunning ? "Pause" : "Start")
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                
                Button("Stop") {
                    timerManager.stop()
                    print("Total Time: \(timerManager.timeElapsed) secs")
                    if let user = users.first {
                        SessionStop(user: user, business: business, time: timerManager.timeElapsed)
                    }
                    
                }
            }
        }
        .sheet(isPresented: $showSessionStats){
           
        }
        .onAppear {
            timerManager.start()
            isTimerActive = true
        }
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
    BusinessViewTimer(business: BusinessDataModel(businessName: "Kians Coffee Cafe", businessTheme: "red", businessType: "Eco-Friendly", businessIcon: "controller"), isTimerActive: .constant(true))
        .environmentObject(ThemeManager())
}

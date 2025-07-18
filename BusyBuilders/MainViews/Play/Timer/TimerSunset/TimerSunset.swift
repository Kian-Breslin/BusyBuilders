//
//  TimerSunset.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 17/07/2025.
//
import SwiftUI
import SwiftData

struct TimerSunset: View {
    @EnvironmentObject var userManager: UserManager
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.dismiss) var dismiss
    @Query var users : [UserDataModel]
    
    @StateObject var timerManager = TimerManager()
    @Binding var isTimerActive : Bool
    
    @State var showSessionStats = false
    
    @State private var sessionStats: SessionDataModel? = nil
    
    @State var showClockOutButton = false
    @State var changeIcon = false
    
    // Colors
    let textColor = Color(red: 0.8, green: 0.4, blue: 0.1)
    
    // Battery
    @State var icon1TextValue: Int? = nil
    @State var icon1Name: String = "battery.100"
    @State var icon1Color: String = "green"
    
    var body: some View {
        ZStack {
            Image("GrayscaleMountainView")
                .resizable()
                .ignoresSafeArea()
            
            VStack (alignment: .leading, spacing: 0){
                HStack {
                    Text("today is")
                        .font(.system(size: 25))
                        .bold()
                    
                    Spacer()
                    
                    Image(systemName: timerManager.isRunning ? "pause" : "play")
                        .font(.system(size: 20))
                        .bold()
                        .onTapGesture {
                            if timerManager.isRunning {
                                timerManager.pause()
                                withAnimation(.linear(duration: 0.4), {
                                    showClockOutButton.toggle()
                                })
                            } else {
                                timerManager.start()
                                withAnimation(.linear(duration: 0.4), {
                                    showClockOutButton.toggle()
                                })
                            }
                        }
                    
                    if showClockOutButton {
                        HStack {
                            Text("Clock Out")
                                .font(.system(size: 12))
                                .bold()
                            Image(systemName: "xmark")
                                .font(.system(size: 20))
                                .bold()
                                .onTapGesture {
                                    DispatchQueue.main.async {
                                        if let user = users.first {
                                            let newSession = user.MakeSession(time: timerManager.timeElapsed)
                                            sessionStats = newSession
                                            showSessionStats.toggle()
                                        }
                                    }
                                }

                        }
                        .foregroundStyle(textColor)
                        .padding(6)
                        .background (
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(textColor, lineWidth: 2)
                        )
                        .transition(.move(edge: .trailing))
                    }
                }
                
                
                Text("Monday")
                    .foregroundStyle(textColor)
                    .font(.londrina(size: 100))
                
                HStack (spacing: 30){
                    HStack (spacing: 5){
                        Image(systemName: "calendar")
                            .foregroundStyle(textColor)
                        Text("16/07")
                            .bold()
                    }
                    HStack (spacing: 5){
                        Image(systemName: "\(icon1Name)")
                            .foregroundStyle(getColor("\(icon1Color)"))
                        Text("\(icon1TextValue ?? 0)%")
                            .bold()
                    }
                    HStack (spacing: 5){
                        Image(systemName: "clock")
                            .foregroundStyle(textColor)
                        Text("\(timerManager.timeElapsed)")
                            .bold()
                    }
                }
                .font(.system(size: 15))
                
                Spacer()
            }
            .frame(width: screenWidth-20, alignment: .leading)
            .foregroundStyle(userManager.mainColor)
        }
        .onAppear {
            UIDevice.current.isBatteryMonitoringEnabled = true
            let rawBatteryLevel = UIDevice.current.batteryLevel
            let batteryLevel: Int

            if rawBatteryLevel < 0 {
                batteryLevel = 0  // or any fallback value, or nil if you prefer
            } else {
                batteryLevel = Int(rawBatteryLevel * 100)
            }
            icon1TextValue = batteryLevel
            if batteryLevel >= 90 {
                icon1Name = "battery.100"
                icon1Color = "green"
            } else if batteryLevel >= 40 {
                icon1Name = "battery.50"
                icon1Color = "green"
            } else {
                icon1Name = "battery.25"
                icon1Color = "red"
            }
            timerManager.start()
            isTimerActive = true
        }
        .sheet(isPresented: $showSessionStats) {
            if let sessionStats = sessionStats {
                BeachViewEndScreen(sessionStats: sessionStats)
                    .presentationDetents([.fraction(0.7)])
                    .onDisappear {
                        print("Closed Sheet -> Close Timer")
                        dismiss()
                    }
            } else {
                Text("No session data available.")
            }
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
    TimerSunset(isTimerActive: .constant(true))
        .environmentObject(UserManager())
}

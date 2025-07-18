//
//  TimerBeach.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 17/07/2025.
//

import SwiftUI
import SwiftData

struct BeachViewTimer: View {
    @EnvironmentObject var userManager : UserManager
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.dismiss) var dismiss
    @Query var users : [UserDataModel]
    
    
    @StateObject var timerManager = TimerManager()
    @Binding var isTimerActive : Bool
    
    @State var showSessionStats = false

    @State private var sessionStats: SessionDataModel? = nil
    
    // Battery
    @State var icon1TextValue: Int? = nil
    @State var icon1Name: String = "battery.100"
    @State var icon1Color: String = "green"
    
    @State var showBusiness = false
    
    var body: some View {
        ZStack {
            Image("SeaSideBackground")
                .resizable()
                .ignoresSafeArea()
                
            contentSection
                .padding(.top, 150)
        }
        .sheet(isPresented: $showSessionStats) {
            if let sessionStats = sessionStats {
                BeachViewEndScreen(sessionStats: sessionStats)
                    .presentationDetents([.fraction(0.7)])
                    .onDisappear {
                        dismiss()
                    }
            } else {
                Text("No session data available.")
            }
        }
        .onAppear {
            setupTimerAndBattery()
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
    
    private var contentSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("Good afternoon!")
                Spacer()
                Image(systemName: timerManager.isRunning ? "pause" : "play")
                    .font(.system(size: 15))
                    .onTapGesture {
                        if timerManager.isRunning {
                            timerManager.pause()
                            withAnimation(.linear(duration: 0.3)){
                                showBusiness = true
                            }
                        } else {
                            timerManager.start()
                            withAnimation(.linear(duration: 0.3)){
                                showBusiness = false
                            }
                        }
                    }
                if showBusiness {
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
                                        user.availableBalance += newSession.total
                                        showSessionStats.toggle()
                                    }
                                }
                            }

                    }
                    .foregroundStyle(userManager.mainColor)
                    .padding(6)
                    .background (
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(userManager.mainColor, lineWidth: 2)
                    )
                    .transition(.move(edge: .trailing))
                }
            }
            .font(.caption)
            Text("Today in Vienna, the temperature is 28°C")
                .font(.headline)
            Divider().frame(height: 2)

            HStack {
                iconItems(icon: "calendar", iconColor: "red", text: " 17", textType: "th")
                Spacer()
                iconItems(icon: "clock", iconColor: "blue", text: " \(timerManager.timeElapsed)", textType: "")
                Spacer()
                iconItems(icon: icon1Name, iconColor: icon1Color, text: "", textValue: $icon1TextValue, textType: "%")
            }
        }
        .foregroundStyle(.black)
        .frame(width: screenWidth - 80, height: screenHeight / 2.3, alignment: .leading)
    }
    
    private func setupTimerAndBattery() {
        UIDevice.current.isBatteryMonitoringEnabled = true
        let rawBatteryLevel = UIDevice.current.batteryLevel
        let batteryLevel = rawBatteryLevel < 0 ? 0 : Int(rawBatteryLevel * 100)
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
    }
}

@ViewBuilder
func iconItems(icon: String, iconColor: String, text: String, textValue: Binding<Int?>? = nil, textType: String) -> some View {
    HStack (spacing: 0){
        Image(systemName: icon)
            .foregroundStyle(getColor(iconColor))
        
        if let value = textValue?.wrappedValue {
            Text("\(text) \(value)\(textType)")
                .bold()
        } else {
            Text("\(text)\(textType)")
                .bold()
        }
            
    }
    .font(.system(size: 12))
}

#Preview {
    BeachViewTimer(isTimerActive: .constant(false))
        .environmentObject(UserManager())
}

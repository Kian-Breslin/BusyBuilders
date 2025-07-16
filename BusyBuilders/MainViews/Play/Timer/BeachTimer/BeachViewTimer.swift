//
//  BusinessViewTimer.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 14/07/2025.
//

import SwiftUI
import SwiftData

struct BeachViewTimer: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.dismiss) var dismiss
    @Query var users : [UserDataModel]
    @State var business : BusinessDataModel
    
    @StateObject var timerManager = TimerManager()
    @Binding var isTimerActive : Bool
    
    @State var showSessionStats = false

    @State private var sessionStats: SessionDataModel? = nil
    
    // Individual Screen Variables
    /// Humidity
    @State var icon2TextValue = 0
    /// Battery
    @State var icon1TextValue: Int? = nil
    @State var icon1Name: String = "battery.100"
    @State var icon1Color: String = "green"
    
    @State var showBusiness = false
    
    var body: some View {
        ZStack {
            Image("SeaSideBackground")
                .resizable()
                .ignoresSafeArea()
                
            VStack(spacing: 20) {
                Spacer()
                VStack (alignment: .leading, spacing: 20){
                    HStack {
                        Text("Good afternoon!")
                        
                        Spacer()
                        
                        Image(systemName: "\(timerManager.isRunning ? "pause" : "play")")
                            .font(.system(size: 15))
                            .onTapGesture {
                                if timerManager.isRunning {
                                    timerManager.pause()
                                    showBusiness = true
                                } else {
                                    timerManager.start()
                                }
                            }
                        
                        Image(systemName: "\(showBusiness ? "eye" : "eye.slash")")
                            .font(.system(size: 15))
                            .onTapGesture {
                                showBusiness.toggle()
                            }
                            
                            
                    }
                    .font(.caption)
                
                    Text("Today in Vienna, the temperature is 28°C")
                        .font(.headline)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: .infinity, height: 2)
                    
                    HStack {
                        iconItems(icon: "calendar", iconColor: "red", text: " \(getDateComponents(from: Date.now)[1]) \(getDateComponents(from: Date.now)[0])", textType: "th")
                        Spacer()
                        iconItems(icon: "clock", iconColor: "blue", text: " \(formatTime(seconds: timerManager.timeElapsed))", textType: "")
                        Spacer()
                        iconItems(icon: icon1Name, iconColor: icon1Color, text: "", textValue: $icon1TextValue, textType: "%")
                    }
                    
                    Spacer()
                    
                    VStack {
                        HStack {
                            Text("\(business.businessName)")
                            Spacer()
                            Text("$\((business.cashPerMin * timerManager.timeElapsed)/60)")
                        }
                        
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                            .frame(width: .infinity, height: 50)
                            .overlay {
                                Text("Clock Out")
                            }
                            .onTapGesture {
                                if let user = users.first {
                                    sessionStats = SessionStop(user: user, business: business, time: timerManager.timeElapsed)
                                    timerManager.stop()
                                    showSessionStats.toggle()
                                } else {
                                    print("Completed Session")
                                    timerManager.stop()
                                    showSessionStats.toggle()
                                }
                            }
                    }
                    .opacity(showBusiness ? 1 : 0)
                    .animation(.linear, value: showBusiness)
                }
                .foregroundStyle(.black)
                .frame(width: screenWidth-80, height: screenHeight/2.3, alignment: .leading)
                
            }
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
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                timerManager.start()
            } else {
                timerManager.pause()
            }
        }
    }
}

struct iconItems: View {
    let icon : String
    let iconColor : String
    
    let text: String
    var textValue: Binding<Int?>?
    let textType: String

    var body: some View {
        HStack (spacing: 0){
            Image(systemName: icon)
                .foregroundStyle(getColor(iconColor))
            
            if let textValue = textValue?.wrappedValue {
                Text("\(text) \(textValue)\(textType)")
                    .bold()
            } else {
                Text("\(text)\(textType)")
                    .bold()
            }
                
        }
        .font(.system(size: 12))
    }
}

#Preview {
    BeachViewTimer(business: BusinessDataModel(businessName: "Kians Coffee Cafe", businessTheme: "red", businessType: "Eco-Friendly", businessIcon: "controller"), isTimerActive: .constant(true))
        .environmentObject(ThemeManager())
}

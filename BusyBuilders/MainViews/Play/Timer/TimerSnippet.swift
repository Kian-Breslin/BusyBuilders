////
////  TimerSnippet.swift
////  BusyBuilders
////
////  Created by Kian Breslin on 16/07/2025.
////
//
//import SwiftUI
//import SwiftData
//
//struct <#name#>: View {
//    @EnvironmentObject var themeManager: ThemeManager
//    @Environment(\.scenePhase) var scenePhase
//    @Environment(\.dismiss) var dismiss
//    @Query var users : [UserDataModel]
//    @State var business : BusinessDataModel
//    
//    @StateObject var timerManager = TimerManager()
//    @Binding var isTimerActive : Bool
//    
//    @State var showSessionStats = false
//
//    @State private var sessionStats: SessionDataModel? = nil
//    
//    var body: some View {
//        ZStack {
//            <#code#>
//        }
//        .onAppear {
//            timerManager.start()
//            isTimerActive = true
//        }
//        .onChange(of: scenePhase) {
//            if scenePhase == .active {
//                timerManager.start()
//            } else {
//                timerManager.pause()
//            }
//        }
//    }
//}
//
//#Preview {
//    <#name#>(business: BusinessDataModel(businessName: "Kians Coffee Cafe", businessTheme: "red", businessType: "Eco-Friendly", businessIcon: "controller"), isTimerActive: .constant(true))
//        .environmentObject(ThemeManager())
//}

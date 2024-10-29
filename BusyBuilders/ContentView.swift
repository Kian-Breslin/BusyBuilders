//
//  ContentView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 23/09/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Query var users: [UserDataModel]
    
    @State var selectedView = 0
    @State var isTaskActive = false
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        if userManager.isUserCreated == false {
            UserSignUp()
        }
        else {
            ZStack {
                if (selectedView == 0) {
                    Dashboard(dashboardSelection: $selectedView)
                } else if selectedView == 1 {
                    Communities()
                } else if selectedView == 2 {
                    StartTask(isTimerActive: $isTaskActive)
                } else if selectedView == 3 {
                    Store()
                } else if selectedView == 4 {
                    Portfolio()
                }
                
                VStack {
                    Spacer()
                    NavigationBar(selectedView: $selectedView)
                        .opacity(isTaskActive ? 0 : 1)
                }
                .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [UserDataModel.self], inMemory: true)
        .environmentObject(UserManager())
}

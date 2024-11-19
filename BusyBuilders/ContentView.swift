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
    @State var isSettingsShowing = false
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        if userManager.isUserCreated == false {
            Onboarding()
        }
        else {
            ZStack {
                if (selectedView == 0) {
                    Dashboard(dashboardSelection: $selectedView, isSettingsShowing: $isSettingsShowing)
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
            .fullScreenCover(isPresented: $isSettingsShowing) {
                Settings()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [UserDataModel.self], inMemory: true)
        .environmentObject(UserManager())
        .environmentObject(ThemeManager())
}

/*
 
 Update : Update Name
 
 Dashboard:

 - N/A

 Communities:

 - N/A

 Play:

 - N/A

 Store:

 - N/A

 Portfolio:

 - N/A

 Back-End:

 - N/A

 Other:

 - N/A
 
 */

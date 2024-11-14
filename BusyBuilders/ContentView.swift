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
    
    let DashboardButtonImages = ["house", "list.bullet", "banknote", "archivebox"]
    let CommunitiesButtonImages = ["person.2.fill", "message.fill", "bubble.left.and.bubble.right.fill", "flag.fill"]
    let StartTaskButtonImages = ["sparkles", "dollarsign.circle", "scissors", "tray.full"]
    let StoreButtonImages = ["arrow.up.circle", "paintbrush", "cube.box.fill", "star.circle.fill"]
    let PortfolioButtonImages = ["person", "building", "building.columns", "chart.line.flattrend.xyaxis"]

    let DashboardButtonTitles = ["Home", "List", "Bank", "Inventory"]
    let CommunitiesButtonTitles = ["People", "Messages", "Chat", "Disputes"]
    let StartTaskButtonTitles = ["XPBooster", "CashBooster", "CostReduction", "Inventory"]
    let StoreButtonTitles = ["Upgrades", "Cosmetics", "Packs", "Specials"]
    let PortfolioButtonTitles = ["My Stats", "My Businesses", "My City", "Investments"]
    
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

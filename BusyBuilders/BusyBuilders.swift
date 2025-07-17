//
//  BusyBuildersApp.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 23/09/2024.
//

import SwiftUI
import SwiftData

@main
struct BusyBuilders: App {
    
    var userManager = UserManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [UserDataModel.self, BusinessDataModel.self])
                .environmentObject(UserManager())
        }
    }
}

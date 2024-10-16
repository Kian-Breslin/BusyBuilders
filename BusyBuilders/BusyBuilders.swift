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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [UserDataModel.self, BusinessDataModel.self, SessionDataModel.self])
        }
    }
}

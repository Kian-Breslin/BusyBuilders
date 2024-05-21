//
//  BusyBuildersApp.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 20/05/2024.
//

import SwiftUI
import SwiftData

@main
struct BusyBuildersApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: BusinessDataModel.self)
    }
}

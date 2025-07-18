//
//  Dashboard.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 17/07/2025.
//

import SwiftUI
import SwiftData

struct Dashboard: View {
    @EnvironmentObject var userManager: UserManager
    @State var selectedIcon = "house"
    var body: some View {
        VStack {
            TopNavigation(title: "Dashboard", iconNames: ["house", "banknote", "newspaper", "helmet"], iconLabels: ["Home", "Bank", "News", "Placeholder"], selectedIcon: $selectedIcon)
            Spacer()
        }
        .background(userManager.mainColor)
        
        VStack {
            if selectedIcon == "house" {
                DashboardHome()
                
            } else if selectedIcon == "banknote" {
                DashboardBank()
            }
            else if selectedIcon == "newspaper" {
                DashboardNews()
            }
        }
        .background(userManager.mainColor)
    }
}

#Preview {
    Dashboard()
        .environmentObject(UserManager())
}

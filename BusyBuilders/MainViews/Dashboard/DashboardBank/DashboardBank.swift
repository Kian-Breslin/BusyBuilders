//
//  DashboardBank.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 17/07/2025.
//

import SwiftUI
import SwiftData

struct DashboardBank: View {
    @EnvironmentObject var userManager: UserManager
    var body: some View {
        ScrollView {
            VStack {
                Text("BANK")
            }
        }
        .scrollIndicators(.hidden)
        .padding(.top, 15)
        .frame(width: screenWidth, height: screenHeight-240)
        .background(userManager.secondaryColor)
        .foregroundStyle(userManager.mainColor)
    }
}

#Preview {
    Dashboard()
        .environmentObject(UserManager())
}

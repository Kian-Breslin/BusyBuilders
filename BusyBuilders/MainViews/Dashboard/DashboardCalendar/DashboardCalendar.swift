//
//  DashboardCalendar.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 14/08/2025.
//

import SwiftUI
import SwiftData

struct DashboardCalendar: View {
    @EnvironmentObject var userManager: UserManager
    var body: some View {
        ScrollView {
            VStack {
                Text("Placeholder")
            }
        }
        .scrollIndicators(.hidden)
        .padding(.top, 15)
        .frame(width: screenWidth, height: screenHeight-240)
        .background(userManager.secondaryColor)
        .foregroundStyle(userManager.mainColor)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    Text("Hello World")
}

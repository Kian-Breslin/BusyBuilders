//
//  DashboardHomeView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 18/11/2024.
//

import SwiftUI

struct DashboardHomeView: View {
    @EnvironmentObject var themeManager: ThemeManager
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    DashboardHomeView()
        .environmentObject(ThemeManager())
}

//
//  DashboardHomeView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 18/11/2024.
//

import SwiftUI
import SwiftData

struct DashboardHomeView: View {
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        
        VStack (spacing: 5) {

            HStack (spacing: 5){
                UserNetWorthWidget()
                
                MediumModularWidget(MainSessions: [])
            }
            
            HStack (spacing: 5){
                SquareModularWidget(sessions: [])

                VStack (spacing: 5){
                    HStack (spacing: 5){
                        BabyModularWidget(numberDisplay: 0)
                        BabyModularWidget(numberDisplay: 1)
                    }
                    HStack (spacing: 5){
                        BabyModularWidget(numberDisplay: 2)
                        BabyModularWidget(numberDisplay: 3)
                    }
                }
            }
            
            RectangleMediumModularWidget()
            
//            OverviewChartWidget()
        }
        .foregroundStyle(themeManager.mainColor)
        .frame(width: screenWidth)
    }
}

#Preview {
    ZStack {
        getColor(ThemeManager().mainDark).ignoresSafeArea()
        DashboardHomeView()
            .environmentObject(ThemeManager())
    }
}

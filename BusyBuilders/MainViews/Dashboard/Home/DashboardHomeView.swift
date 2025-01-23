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
        
        VStack (spacing: 5) {

            HStack (spacing: 5){
                UserNetWorthWidget()
                
                MediumModularWidget()
            }
            
            HStack (spacing: 5){
                SquareModularWidget()

                VStack (spacing: 5){
                    HStack (spacing: 5){
                        BabyModularWidget(numberDisplay: 1)
                        BabyModularWidget(numberDisplay: 2)
                    }
                    HStack (spacing: 5){
                        BabyModularWidget(numberDisplay: 3)
                        BabyModularWidget(numberDisplay: 4)
                    }
                }
            }
            
            RectangleMediumModularWidget()
            
            OverviewChartWidget()
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

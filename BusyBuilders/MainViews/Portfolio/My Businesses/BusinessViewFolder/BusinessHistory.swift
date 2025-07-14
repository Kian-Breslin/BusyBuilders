//
//  BusinessHistory.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 07/06/2025.
//

import SwiftUI

struct BusinessHistory: View {
    @EnvironmentObject var themeManager: ThemeManager
    let business : BusinessDataModel
    var body: some View {
        ZStack {
            themeManager.mainColor.ignoresSafeArea()
            
            VStack {
                ScrollView {
                    VStack {
                        ForEach(business.sessionHistory, id: \.self) { s in
                            historyItem(session: s)
                        }
                    }
                }
            }
            .padding(.top, 10)
            .padding(.bottom, 35)
        }
    }
}

struct historyItem: View {
    let session : SessionDataModel
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: screenWidth-20, height: 150)
            .foregroundStyle(getColor(ThemeManager().mainDark))
            .overlay (alignment: .leading){
                VStack(alignment: .leading){
                    HStack {
                        Text("\(getDateMonthYear(from: session.sessionDate) ?? "No date found")")
                        Text("- \(timeFormattedWithText(session.totalStudyTime))")
                        Text("XP: \(session.totalXPEarned)")
                            .font(.system(size: 20))
                            .bold()
                    }
                    Text("Cash: $\(session.totalCashEarned)")
                        .font(.system(size: 20))
                        .foregroundStyle(.green)
                    Text("Products: $0")
                        .font(.system(size: 20))
                        .foregroundStyle(.green)
                    Text("Costs: $\(session.totalCostIncurred)")
                        .font(.system(size: 20))
                        .foregroundStyle(getColor("red"))
                    Text("Total: $\((session.totalCashEarned + 0) - session.totalCostIncurred)")
                        .font(.system(size: 20))
                }
                .foregroundStyle(ThemeManager().textColor)
                .font(.system(size: 18))
                .padding(10)
            }
    }
}

#Preview {
    VStack (spacing: 0){
        Rectangle()
            .frame(width: screenWidth, height: 230)
        
        BusinessHistory(business: BusinessDataModel(businessName: "Fake Name", businessTheme: "red", businessType: "Eco-friendly", businessIcon: "triangle", owners: [], time: 4000, investment: 0, investors: [], badges: [], upgrades: [], sessionHistory: [], leaderboardPosition: 2, insuranceLevel: 2, securityLevel: 2, businessPrestige: "", streak: 2, creationDate: Date.now))
            .environmentObject(ThemeManager())
        
        Spacer()
    }
    .ignoresSafeArea()
}

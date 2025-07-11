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
                        Text("XP: $\(session.totalXPEarned)")
                            .font(.system(size: 20))
                            .bold()
                    }
                    Text("Cash: $\(session.totalCashEarned)")
                        .font(.system(size: 20))
                        .foregroundStyle(.green)
                    Text("Products: $\(session.productRevenue)")
                        .font(.system(size: 20))
                        .foregroundStyle(.green)
                    Text("Costs: $\(session.totalCostIncurred)")
                        .font(.system(size: 20))
                        .foregroundStyle(getColor("red"))
                    Text("Total: $\((session.totalCashEarned + session.productRevenue) - session.totalCostIncurred)")
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
        
        BusinessHistory(business: BusinessDataModel(businessName: "Fake Name", businessTheme: "red", businessType: "Eco-friendly", businessIcon: "triangle", owners: [], time: 4000, netWorth: 3000000, investment: 0, investors: [], badges: [], upgrades: [], sessionHistory: [SessionDataModel(id: UUID(), sessionDate: Date.now, sessionStart: "01/01/25", sessionEnd: "01/01/25", businessId: UUID(), totalCashEarned: 10000, totalCostIncurred: 1000, totalXPEarned: 7200, totalStudyTime: 7200),SessionDataModel(id: UUID(), sessionDate: Date.now, sessionStart: "01/01/25", sessionEnd: "01/01/25", businessId: UUID(), totalCashEarned: 20000, totalCostIncurred: 1000, totalXPEarned: 7200, totalStudyTime: 17200),SessionDataModel(id: UUID(), sessionDate: Date.now, sessionStart: "01/01/25", sessionEnd: "01/01/25", businessId: UUID(), totalCashEarned: 15000, totalCostIncurred: 1000, totalXPEarned: 7200, totalStudyTime: 7200)], leaderboardPosition: 2, insuranceLevel: 2, securityLevel: 2, businessPrestige: "", streak: 2, creationDate: Date.now))
            .environmentObject(ThemeManager())
        
        Spacer()
    }
    .ignoresSafeArea()
}

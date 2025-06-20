//
//  BusinessOverview.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 08/05/2025.
//

import SwiftUI

struct BusinessOverview: View {
    @EnvironmentObject var themeManager: ThemeManager
    let business : BusinessDataModel
    
    var body: some View {
        ZStack {
            themeManager.mainColor
                .ignoresSafeArea()
            
            VStack (alignment: .leading, spacing: 5){
                
                Text("Net Worth:")
                    .font(.system(size: 25))
                Text("$\(business.netWorth)")
                
                Text("Cash per Minute:")
                    .font(.system(size: 25))
                Text("$\(business.cashPerMin)")
                
                Text("Business Level:")
                    .font(.system(size: 25))
                Text("\(business.businessLevel)")
                
                Text("Recent Sessions:")
                    .font(.system(size: 25))
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(business.sessionHistory, id: \.self){ s in
                            sessionHistoryWidget(session: s)
                        }
                    }
                }
                Spacer()
            }
            .font(.system(size: 20))
            .foregroundStyle(themeManager.textColor)
            .frame(width: screenWidth-20, alignment: .leading)
            .padding(.top, 10)
        }
    }
}

struct sessionHistoryWidget: View{
    let session : SessionDataModel
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .frame(width: 150, height: 80)
            .foregroundStyle(ThemeManager().textColor)
            .overlay {
                Text("$\(session.totalCashEarned)")
            }
            .foregroundStyle(ThemeManager().mainColor)
    }
}

#Preview {
    VStack (spacing: 0){
        Rectangle()
            .frame(width: screenWidth, height: 230)
        
        BusinessOverview(business: BusinessDataModel(businessName: "Fake Name", businessTheme: "red", businessType: "Eco-friendly", businessIcon: "triangle", owners: [], time: 4000, cashPerMin: 2000, netWorth: 3000000, costPerMin: 500, investment: 0, investors: [], badges: [], upgrades: [], sessionHistory: [SessionDataModel(id: UUID(), sessionDate: Date.now, sessionStart: "01/01/25", sessionEnd: "01/01/25", businessId: UUID(), totalCashEarned: 10000, totalCostIncurred: 1000, totalXPEarned: 7200, totalStudyTime: 7200),SessionDataModel(id: UUID(), sessionDate: Date.now, sessionStart: "01/01/25", sessionEnd: "01/01/25", businessId: UUID(), totalCashEarned: 20000, totalCostIncurred: 1000, totalXPEarned: 7200, totalStudyTime: 7200),SessionDataModel(id: UUID(), sessionDate: Date.now, sessionStart: "01/01/25", sessionEnd: "01/01/25", businessId: UUID(), totalCashEarned: 15000, totalCostIncurred: 1000, totalXPEarned: 7200, totalStudyTime: 7200)], leaderboardPosition: 2, insuranceLevel: 2, securityLevel: 2, businessLevel: 2, businessPrestige: "", streak: 2, creationDate: Date.now))
            .environmentObject(ThemeManager())
        
        Spacer()
    }
    .ignoresSafeArea()
}

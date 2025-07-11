//
//  Sessions.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 09/11/2024.
//

import SwiftUI

struct Sessions: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @State var business : BusinessDataModel
    
    var body: some View {
        ZStack {
            themeManager.mainColor
                .ignoresSafeArea()
            
            VStack (alignment:.leading){
                
                Text("Sessions")
                    .font(.system(size: 40))
                    .foregroundStyle(themeManager.textColor)
                
                ScrollView (.vertical){
                    VStack {
                        ForEach(business.sessionHistory) { s in
                            VStack (alignment:.leading){
                                Text("\(getDayMonthYear(from: s.sessionDate) ?? "")")
                                    .font(.system(size: 20))
                                
                                Text("\(timeFormattedSecToString(s.totalStudyTime))")
                                    .font(.system(size: 18))
                            }
                            .foregroundStyle(themeManager.mainColor)
                            .frame(width: screenWidth-20, height: 100)
                            .background(themeManager.textColor)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    Sessions(business: BusinessDataModel(
        businessName: "Kians Shop",
        businessTheme: "Blue",
        businessType: "Economic",
        businessIcon: "triangle",
        owners: [UserDataModel(username: "Kian_17", name: "Kian", email: "Kianbreslin@gmail.com")],
        netWorth: 6000,
        investors: [],
        badges: ["10 Days Streak", "$1000 Earned", "First Upgrade"],
        sessionHistory:
            [SessionDataModel(
                id: UUID(),
                sessionDate: Date.now,
                sessionStart: formatFullDateTime(date: Date()),
                sessionEnd: formatFullDateTime(date: Date()),
                businessId: UUID(), totalCashEarned: 3454),
             SessionDataModel(
                 id: UUID(),
                 sessionDate: Date.now,
                 sessionStart: formatFullDateTime(date: Date()),
                 sessionEnd: formatFullDateTime(date: Date()),
                 businessId: UUID(), totalCashEarned: 5436)
            ],
        businessPrestige: "Growing Business"))
    .environmentObject(ThemeManager())
}

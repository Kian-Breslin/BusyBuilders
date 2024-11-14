//
//  Sessions.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 09/11/2024.
//

import SwiftUI

struct Sessions: View {
    
    @State var business : BusinessDataModel
    
    var body: some View {
        ZStack {
            getColor("Black")
                .ignoresSafeArea()
            
            VStack (alignment:.leading){
                
                Text("Sessions")
                    .font(.system(size: 40))
                    .foregroundStyle(getColor("white"))
                
                ScrollView (.vertical){
                    VStack {
                        ForEach(business.sessionHistory) { s in
                            VStack (alignment:.leading){
                                Text("\(getDayMonthYear(from: s.sessionDate) ?? "")")
                                    .font(.system(size: 20))
                                
                                Text("\(timeFormattedSecToString(s.totalStudyTime))")
                                    .font(.system(size: 18))
                            }
                            .foregroundStyle(getColor("black"))
                            .frame(width: screenWidth-30, height: 100)
                            .background(getColor("white"))
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
        cashPerMin: 3000,
        netWorth: 6000,
        investors: [],
        badges: ["10 Days Streak", "$1000 Earned", "First Upgrade"],
        sessionHistory:
            [SessionDataModel(
                id: UUID(),
                sessionDate: Date.now,
                sessionStart: formatFullDateTime(date: Date()),
                sessionEnd: formatFullDateTime(date: Date()),
                totalStudyTime: 1452, businessId: UUID()),
             SessionDataModel(
                 id: UUID(),
                 sessionDate: Date.now,
                 sessionStart: formatFullDateTime(date: Date()),
                 sessionEnd: formatFullDateTime(date: Date()),
                 totalStudyTime: 1874, businessId: UUID())
            ],
        businessLevel: 7200,
        businessPrestige: "Growing Business"))
}

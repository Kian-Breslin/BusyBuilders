//
//  BusinessNavigationDestination.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 13/11/2024.
//

import SwiftUI

struct BusinessNavigationDestination: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State var business : BusinessDataModel
    var body: some View {
        ZStack {
            getColor("\(business.businessTheme)")
                .ignoresSafeArea()
            VStack {
                HStack {
                    Text("\(business.businessName)")
                        .bold()
                        
                    
                    Spacer()
                    
                    NavigationLink (destination: BusinessSettings(business: business)) {
                        Image(systemName: "gearshape.fill")
                    }
                }
                .frame(width: screenWidth-20)
                .font(.system(size: 30))
                .foregroundStyle(themeManager.textColor)
                
                ScrollView (.vertical, showsIndicators: false){
                    VStack (alignment: .leading){
                        Group {
                            Text("Total Net Worth")
                            Text("$\(business.netWorth)")
                                .font(.system(size: 35))
                        }
                        Group {
                            Text("Prestige")
                            Text("\(getPrestige(getLevelFromSec(business.businessLevel)))")
                                .font(.system(size: 35))
                        }
                        Group {
                            Text("Level")
                            Text("\(getLevelFromSec(business.businessLevel))")
                                .font(.system(size: 35))
                        }
                        Group {
                            Text("Total Study Time")
                            Text("\(timeFormattedWithText(business.time))")
                                .font(.system(size: 35))
                        }
                    }
                    .frame(width: screenWidth-20, alignment: .leading)
                    
                    HStack (spacing: 10){
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: (screenWidth-30)/2, height: (screenWidth-30)/2)
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: (screenWidth-30)/2, height: (screenWidth-30)/2)
                    }
                    
                    
                    
                    
                    
                    
//                    NavigationLink(destination: BusinessSessionsView(currentBusiness: business)){
//                            Text("List of Sessions")
//                        }
                    }
                    .padding(.bottom, 55)
                    .padding(.top, 5)
                }
            }
            .foregroundStyle(themeManager.textColor)
    }
}

#Preview {
    BusinessNavigationDestination(business: BusinessDataModel(
        businessName: "Kians Shop",
        businessTheme: "Blue",
        businessType: "Economic",
        businessIcon: "triangle",
        owners: [UserDataModel(username: "Kian_17", name: "Kian", email: "Kianbreslin@gmail.com")],
        time: 9360,
        cashPerMin: 3000,
        netWorth: 60000,
        investors: [
            UserDataModel(username: "LilKimmy", name: "Kim", email: "Kim@gmail.com"),
            UserDataModel(username: "LilJimmy", name: "Jim", email: "Jim@gmail.com"),
            UserDataModel(username: "LilLimmy", name: "Lim", email: "Lim@gmail.com"),
            UserDataModel(username: "LilPimmy", name: "Pim", email: "Pim@gmail.com"),
            UserDataModel(username: "LilTimmy", name: "Tim", email: "Tim@gmail.com"),
            UserDataModel(username: "LilRimmy", name: "Rim", email: "Rim@gmail.com")
        ],
        badges: ["10 Days Streak", "$1000 Earned", "First Upgrade"],
        sessionHistory:
            [SessionDataModel(
                id: UUID(),
                sessionDate: Date.now,
                sessionStart: formatFullDateTime(date: Date()),
                sessionEnd: formatFullDateTime(date: Date()),
                businessId: UUID(), totalStudyTime: 3600),
             SessionDataModel(
                 id: UUID(),
                 sessionDate: Date.now,
                 sessionStart: formatFullDateTime(date: Date()),
                 sessionEnd: formatFullDateTime(date: Date()),
                 businessId: UUID(), totalStudyTime: 3600)
            ],
        businessLevel: 7200,
        businessPrestige: "Growing Business"))
    .environmentObject(ThemeManager())
}

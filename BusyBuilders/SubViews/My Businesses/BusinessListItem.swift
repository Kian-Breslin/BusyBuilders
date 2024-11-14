//
//  BusinessListItem.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 13/11/2024.
//

import SwiftUI

struct BusinessListItem: View {
    @State var business : BusinessDataModel
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .frame(width: screenWidth-30, height: 100)
            .foregroundStyle(getColor("black"))
            .overlay {
                HStack {
                    VStack (alignment: .leading){
                        Text("\(business.businessName)")
                            .font(.system(size: 25))
                            .bold()
                            .foregroundStyle(getColor("\(business.businessTheme)"))
                        HStack (spacing: 4){
                            Text("Total Net Worth:")
                                .font(.system(size: 12))
                            Text("$\(business.netWorth, specifier: "%.f")")
                                .font(.system(size: 15))
                        }
                        HStack (alignment: .bottom, spacing: 4){
                            Text("Total Time Studied:")
                                .font(.system(size: 12))
                            Text("\(timeComponents(from: business.time)[0])")
                                .font(.system(size: 15))
                            Text("hr")
                                .font(.system(size: 12))
                            Text("\(timeComponents(from: business.time)[1])")
                                .font(.system(size: 15))
                            Text("min")
                                .font(.system(size: 12))
                            Text("\(timeComponents(from: business.time)[2])")
                                .font(.system(size: 15))
                            Text("sec")
                                .font(.system(size: 12))
                        }
                    }
                    Spacer()
                    Image(systemName: "\(business.businessIcon)")
                        .font(.system(size: 50))
                        .foregroundStyle(getColor("\(business.businessTheme)"))
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .padding(10)
                .foregroundStyle(getColor("white"))
            }
    }
}

#Preview {
    BusinessListItem(business: BusinessDataModel(
        businessName: "Kians Shop",
        businessTheme: "Blue",
        businessType: "Economic",
        businessIcon: "triangle",
        owners: [UserDataModel(username: "Kian_17", name: "Kian", email: "Kianbreslin@gmail.com")],
        time: 9360,
        cashPerMin: 3000,
        netWorth: 6000,
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
                totalStudyTime: 3600, businessId: UUID()),
             SessionDataModel(
                 id: UUID(),
                 sessionDate: Date.now,
                 sessionStart: formatFullDateTime(date: Date()),
                 sessionEnd: formatFullDateTime(date: Date()),
                 totalStudyTime: 3600, businessId: UUID())
            ],
        businessLevel: 7200,
        businessPrestige: "Growing Business"))
}

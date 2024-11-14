//
//  BusinessNavigationDestination.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 13/11/2024.
//

import SwiftUI

struct BusinessNavigationDestination: View {
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
                .frame(width: screenWidth-30)
                .font(.system(size: 30))
                .foregroundStyle(getColor("white"))
                
                ScrollView (.vertical, showsIndicators: false){
                    NavigationLink(destination: BusinessNavTotalNetWorth()){
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: screenWidth-30, height: 300)
                                .overlay {
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(getColor("white"))
                                        .offset(x: (screenWidth-60)/2, y: -130)
                                        .opacity(0.5)
                                        .bold()
                                    VStack {
                                        Text("Total Net Worth")
                                            .font(.system(size: 15))
                                        Text("$\(business.netWorth, specifier: "%.f")")
                                            .font(.system(size: 45))
                                            .bold()
                                        
                                        VStack (spacing: 15){
                                            HStack {
                                                Text("Wed 13 Nov")
                                                    .opacity(0.7)
                                                Spacer()
                                                Text("+ $103,400")
                                                    .kerning(2)
                                                    .bold()
                                            }
                                            HStack {
                                                Text("Mon 02 Nov")
                                                    .opacity(0.7)
                                                Spacer()
                                                Text("+ $82,000")
                                                    .kerning(2)
                                                    .bold()
                                            }
                                            HStack {
                                                Text("Sat 27 Oct")
                                                    .opacity(0.7)
                                                Spacer()
                                                Text("+ $33,000")
                                                    .kerning(2)
                                                    .bold()
                                            }
                                        }
                                        .frame(width: screenWidth-70)
                                        .padding(.top)
                                    }
                                    .foregroundStyle(getColor("white"))
                                }
                        }
                    
                        HStack (spacing: 15){
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: ((screenWidth-45)/2), height: ((screenWidth-30)/2)-15)
                                .overlay{
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(getColor("white"))
                                        .offset(x: ((screenWidth-100)/2)/2, y: -((screenWidth-130)/2)/2)
                                        .opacity(0.5)
                                        .bold()
                                }
                                                
                            
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: ((screenWidth-45)/2), height: ((screenWidth-30)/2)-15)
                                .overlay{
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(getColor("white"))
                                        .offset(x: ((screenWidth-100)/2)/2, y: -((screenWidth-130)/2)/2)
                                        .opacity(0.5)
                                        .bold()
                                }
                        }
                    
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: (screenWidth-30), height: ((screenWidth-30)/2)-15)
                            .overlay {
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(getColor("white"))
                                    .offset(x: (screenWidth-60)/2, y: -(((screenWidth-30)/2)-55)/2)
                                    .opacity(0.5)
                                    .bold()
                            }
                    }
                .padding(.bottom, 55)
                .padding(.top, 5)
                }
            }
            .foregroundStyle(getColor("black"))
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

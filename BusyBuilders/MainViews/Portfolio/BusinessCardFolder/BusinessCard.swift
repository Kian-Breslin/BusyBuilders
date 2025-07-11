//
//  BusinessCard.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 04/11/2024.
//

import SwiftUI

struct BusinessCard: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @Environment(\.modelContext) var context
    @State var business : BusinessDataModel
    @State var flipCard = false

    
    var body: some View {
        ZStack {
            CardBack(business: business)
                .rotation3DEffect(.degrees(flipCard ? 0 : -90), axis: (x: 0, y: 1.0, z: 0))
                .animation(flipCard ? .linear.delay(0.35) : .linear, value : flipCard)
                .onTapGesture {
                    withAnimation(.easeIn){
                        flipCard.toggle()
                    }
                }
            
            CardFront(business: business)
                .rotation3DEffect(.degrees(flipCard ? 90 : 0), axis: (x: 0, y: 1.0, z: 0))
                .animation(flipCard ? .linear : .linear.delay(0.35), value : flipCard)
                .onTapGesture {
                    withAnimation(.easeIn){
                        flipCard.toggle()
                    }
                }
        }
    }
}

#Preview {
    BusinessCard(business: BusinessDataModel(
        businessName: "K-Tech",
        businessTheme: "Red",
        businessType: "Economic",
        businessIcon: "macbook",
        owners: [UserDataModel(username: "Kian_17", name: "Kian", email: "Kianbreslin@gmail.com")],
        time: 9360,
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
                businessId: UUID(), totalStudyTime: 3600),
             SessionDataModel(
                 id: UUID(),
                 sessionDate: Date.now,
                 sessionStart: formatFullDateTime(date: Date()),
                 sessionEnd: formatFullDateTime(date: Date()),
                 businessId: UUID(), totalStudyTime: 3600)
            ],
        insuranceLevel: 10,
        securityLevel: 14,
        businessPrestige: "Growing Business"))
    .environmentObject(ThemeManager())
}


struct CardFront: View {
    @EnvironmentObject var themeManager : ThemeManager
    @State var business : BusinessDataModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: screenWidth-150, height: 300)
            .foregroundStyle(getColor(themeManager.mainDark))
            .overlay {
                VStack (spacing: 5){
                    HStack {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 100, height: 100)
                            .foregroundStyle(themeManager.mainColor.shadow(.inner(color: .black, radius: 5, x: 0, y: 5)))
                            .overlay {
                                Image(systemName: "\(business.businessIcon)")
                                    .font(.system(size: 60))
                                    .foregroundStyle(getColor("\(business.businessTheme)"))
                            }
                            
                        VStack (alignment: .leading){
                            Text("\(business.businessName)")
                                .font(.system(size: 20))
                                .bold()
                                .lineLimit(2)
                                .clipped()
                            
                            Text("Established: ").bold()
                                .font(.system(size: 15))
                            Text("\(getDateFormat(from: business.creationDate))")
                                .font(.system(size: 12))
                                
                            Text("Prestige: ").bold()
                                .font(.system(size: 15))
                            Text("\(business.businessPrestige)")
                                .font(.system(size: 12))
                            
                            Spacer()
                        }
                        .font(.system(size: 12))
                        .frame(height: 100)
                        Spacer()
                    }
                    VStack (alignment: .leading){
                        Text("Business Stats")
                            .font(.system(size: 20))
                        
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: screenWidth-170, height: 110)
                            .foregroundStyle(themeManager.mainColor.shadow(.inner(color: .black, radius: 5, x: 0, y: 5)))
                            .overlay (alignment: .leading){
                                VStack (alignment: .leading){
                                    Text("Net Worth: ") + Text("$\(business.netWorth)")
                                    
                                    Text("Time Studied: ") + Text("\(timeFormattedWithText(business.time))")
                                    
                                    Text("Level: ") + Text("\(getLevelFromSec(business.businessLevel))")
                                    
                                    Text("Insurance: ") + Text("\(business.insuranceLevel)")
                                    
                                    Text("Security: ") + Text("\(business.securityLevel)")
                                }
                                .padding(10)
                        }
                    }
                    .font(.system(size: 15))
                    .frame(width: screenWidth-170, alignment: .leading)
                    Spacer()
                }
                .frame(width: screenWidth-170, height: 280)
                .foregroundStyle(themeManager.textColor)
            }
    }
}

struct CardBack: View {
    @EnvironmentObject var themeManager : ThemeManager
    @State var business : BusinessDataModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: screenWidth-150, height: 300)
            .foregroundStyle(getColor(themeManager.mainDark))
            .overlay {
                VStack {
                    HStack {
                        VStack (alignment: .leading){
                            Text("\(business.businessName)")
                                .font(.system(size: 20))
                                .bold()
                                .lineLimit(2)
                                .clipped()
                            
                            Text("Established: ").bold()
                                .font(.system(size: 15))
                            Text("\(getDateFormat(from: business.creationDate))")
                                .font(.system(size: 12))
                                
                            Text("Prestige: ").bold()
                                .font(.system(size: 15))
                            Text("\(business.businessPrestige)")
                                .font(.system(size: 12))
                            
                            Spacer()
                        }
                        .font(.system(size: 12))
                        .frame(height: 100)
                        
                        Spacer()
                    }
                    
                    
                    
                    
                    Spacer()
                    
                    HStack {
                        Button("Edit"){
                            print("Edit")
                        }
                        .frame(width: (screenWidth-170)/2, height: 40)
                        .background(themeManager.mainColor)
                        .foregroundStyle(getColor("\(business.businessTheme)"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        Button("Sell"){
                            print("Sell")
                        }
                        .frame(width: (screenWidth-170)/2, height: 40)
                        .background(themeManager.mainColor)
                        .foregroundStyle(getColor("\(business.businessTheme)"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .foregroundStyle(themeManager.textColor)
                .frame(width: screenWidth-160, height: 290)
            }
    }
}

//
//  BusinessProducts.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 08/06/2025.
//

import SwiftUI

struct BusinessProducts: View {
    @EnvironmentObject var themeManager: ThemeManager
    let business : BusinessDataModel

    var body: some View {
        ZStack {
            themeManager.mainColor.ignoresSafeArea()
            
            VStack {
                ForEach(business.products){ p in
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: screenWidth-20, height: 80)
                        .foregroundStyle(getColor(themeManager.mainDark))
                        .overlay {
                            VStack {
                                Text("\(p.productName)")
                            }
                            .foregroundStyle(themeManager.textColor)
                        }
                }
                Spacer()
            }
            .padding(.top, 10)
        }
        .onAppear {
            business.products.append(ProductDataModel(productName: "KPhone", pricePerUnit: 100, quantity: 100, costToProduce: 80, markupPercentage: 20, productType: "Phone", icon: "phone"))
        }
    }
}

#Preview {
    VStack (spacing: 0){
        Rectangle()
            .frame(width: screenWidth, height: 230)
        
        BusinessProducts(business: BusinessDataModel(businessName: "Fake Name", businessTheme: "red", businessType: "Eco-friendly", businessIcon: "triangle", owners: [], time: 4000, cashPerMin: 2000, netWorth: 3000000, costPerMin: 500, investment: 0, investors: [], badges: [], upgrades: [], sessionHistory: [SessionDataModel(id: UUID(), sessionDate: Date.now, sessionStart: "01/01/25", sessionEnd: "01/01/25", businessId: UUID(), totalCashEarned: 10000, totalCostIncurred: 1000, totalXPEarned: 7200, totalStudyTime: 7200),SessionDataModel(id: UUID(), sessionDate: Date.now, sessionStart: "01/01/25", sessionEnd: "01/01/25", businessId: UUID(), totalCashEarned: 20000, totalCostIncurred: 1000, totalXPEarned: 7200, totalStudyTime: 7200),SessionDataModel(id: UUID(), sessionDate: Date.now, sessionStart: "01/01/25", sessionEnd: "01/01/25", businessId: UUID(), totalCashEarned: 15000, totalCostIncurred: 1000, totalXPEarned: 7200, totalStudyTime: 7200)], leaderboardPosition: 2, insuranceLevel: 2, securityLevel: 2, businessLevel: 2, businessPrestige: "", streak: 2, creationDate: Date.now))
            .environmentObject(ThemeManager())
        
        Spacer()
    }
    .ignoresSafeArea()
}

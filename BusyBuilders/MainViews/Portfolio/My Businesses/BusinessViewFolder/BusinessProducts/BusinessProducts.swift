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

    @State var showCreateProductScreen = false
    var body: some View {
        ZStack {
            themeManager.mainColor.ignoresSafeArea()
            
            ScrollView {
                VStack {
                    ForEach(business.products){ p in
                        NavigationLink(destination: ProductView(product: p)){
                            BusinessProductItemForList(product: p)
                                .onLongPressGesture {
                                    business.products.removeAll(where: {$0.id == p.id})
                                }
                        }
                    }
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: screenWidth-20, height: 80)
                        .foregroundStyle(getColor(themeManager.mainDark))
                        .overlay {
                            Text("Create a new product")
                        }
                        .onTapGesture {
//                            let randomProduct = business.makeRandomProduct()
//                            business.products.append(randomProduct)
                            showCreateProductScreen.toggle()
                        }
                    Spacer()
                }
                .padding(.top, 10)
            }
            .scrollIndicators(.hidden)
            .padding(.bottom, 10)
        }
        .sheet(isPresented: $showCreateProductScreen) {
            CreateNewProduct(business: business)
        }
    }
}

struct BusinessProductItemForList: View {
    @EnvironmentObject var themeManager: ThemeManager
    let product : ProductDataModel
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: screenWidth-20, height: 80)
            .foregroundStyle(getColor(themeManager.mainDark))
            .overlay {
                HStack {
                    VStack (alignment: .leading){
                        Text("\(product.productName)")
                            .font(.system(size: 30))
                        Text("Total Lifetime Sales: $\(product.totalSalesIncome)")
                            .font(.system(size: 15))
                    }
                    Spacer()
                    VStack {
                        Image(systemName: product.icon)
                            .font(.system(size: 50))
                            .foregroundStyle(product.isActive ? .green : .red)
                    }
                }
                .foregroundStyle(themeManager.textColor)
                .padding()
            }
    }
}

#Preview {
    BusinessProductItemForList(product: ProductDataModel(productName: "OPhone", quantity: 100, markupPercentage: 50, productType: "Tech", icon: "iphone", business: BusinessDataModel(businessName: "Fake Name", businessTheme: "red", businessType: "Eco-friendly", businessIcon: "triangle", owners: [], time: 4000, netWorth: 3000000, investment: 0, investors: [], badges: [], upgrades: [], sessionHistory: [SessionDataModel(id: UUID(), sessionDate: Date.now, sessionStart: "01/01/25", sessionEnd: "01/01/25", businessId: UUID(), totalCashEarned: 10000, totalCostIncurred: 1000, totalXPEarned: 7200, totalStudyTime: 7200),SessionDataModel(id: UUID(), sessionDate: Date.now, sessionStart: "01/01/25", sessionEnd: "01/01/25", businessId: UUID(), totalCashEarned: 20000, totalCostIncurred: 1000, totalXPEarned: 7200, totalStudyTime: 7200),SessionDataModel(id: UUID(), sessionDate: Date.now, sessionStart: "01/01/25", sessionEnd: "01/01/25", businessId: UUID(), totalCashEarned: 15000, totalCostIncurred: 1000, totalXPEarned: 7200, totalStudyTime: 7200)], leaderboardPosition: 2, insuranceLevel: 2, securityLevel: 2, businessPrestige: "", streak: 2, creationDate: Date.now)))
        .environmentObject(ThemeManager())
}

#Preview {
    VStack (spacing: 0){
        Rectangle()
            .frame(width: screenWidth, height: 230)
        
        BusinessProducts(business: BusinessDataModel(businessName: "Fake Name", businessTheme: "red", businessType: "Eco-friendly", businessIcon: "triangle", owners: [], time: 4000, netWorth: 3000000, investment: 0, investors: [], badges: [], upgrades: [], sessionHistory: [SessionDataModel(id: UUID(), sessionDate: Date.now, sessionStart: "01/01/25", sessionEnd: "01/01/25", businessId: UUID(), totalCashEarned: 10000, totalCostIncurred: 1000, totalXPEarned: 7200, totalStudyTime: 7200),SessionDataModel(id: UUID(), sessionDate: Date.now, sessionStart: "01/01/25", sessionEnd: "01/01/25", businessId: UUID(), totalCashEarned: 20000, totalCostIncurred: 1000, totalXPEarned: 7200, totalStudyTime: 7200),SessionDataModel(id: UUID(), sessionDate: Date.now, sessionStart: "01/01/25", sessionEnd: "01/01/25", businessId: UUID(), totalCashEarned: 15000, totalCostIncurred: 1000, totalXPEarned: 7200, totalStudyTime: 7200)], leaderboardPosition: 2, insuranceLevel: 2, securityLevel: 2, businessPrestige: "", streak: 2, creationDate: Date.now))
            .environmentObject(ThemeManager())
        
        Spacer()
    }
    .ignoresSafeArea()
}

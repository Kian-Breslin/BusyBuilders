//
//  PortfolioMyStats.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 17/07/2025.
//

import SwiftUI
import SwiftData

struct PortfolioMyStats: View {
    @EnvironmentObject var userManager: UserManager
    @Query var users : [UserDataModel]
    
    @State var isSessionSelected = true
    @State var selectedSession : SessionDataModel? = nil
    @State private var showBusinesses = true
    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 10){
                VStack (alignment: .leading){
//                    Text("Total Networth:")
//                        .font(.caption)
                    if let user = users.first {
//                        Text("$\(user.netWorth)")
//                        
//                        Text("Available Balance:")
//                            .font(.caption)
//                        Text("$\(user.availableBalance)")
                        
//                        Label("\(user.userLevel)", systemImage: "star.fill")
//                            .foregroundStyle(.yellow)
                        
//                        Text("Balance: $\(user.getUserNetworthBreakdown()[0])")
//                        Text("Businesses: $\(user.getUserNetworthBreakdown()[1])")
//                        Text("Items: $\(user.getUserNetworthBreakdown()[2])")
//                        Text("Agencies: $\(user.getUserNetworthBreakdown()[3])")

                        UserChart(values: [
                            user.getUserNetworthBreakdown()[0],
                            user.getUserNetworthBreakdown()[1],
                            user.getUserNetworthBreakdown()[2],
                            user.getUserNetworthBreakdown()[3]
                        ])
                        
                        BusinessChart(businessNetWorth: user.getUserBusinessNetWorth(), businessArray: user.getUserBusinessNetWorthBreakdown())
                        
//                        HStack {
//                            RoundedRectangle(cornerRadius: 10)
//                                .frame(width: (screenWidth-30)/2, height: (screenWidth-30)/2)
//                            
//                            RoundedRectangle(cornerRadius: 10)
//                                .frame(width: (screenWidth-30)/2, height: (screenWidth-30)/2)
//                        }
                    }
                }
            }
            .frame(width: screenWidth-20, alignment: .leading)
            .foregroundStyle(userManager.textColor)
        }
        .scrollIndicators(.hidden)
        .padding(.top, 15)
        .padding(.bottom, 85)
        .frame(width: screenWidth, height: screenHeight-240)
        .background(userManager.secondaryColor)
        .foregroundStyle(userManager.mainColor)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}




#Preview {
    Portfolio(selectedIcon: "book.pages")
        .environmentObject(UserManager())
}


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
                    Text("Total Networth:")
                        .font(.caption)
                    if let user = users.first {
                        Text("$\(user.netWorth)")
                        
                        Text("Available Balance:")
                            .font(.caption)
                        Text("$\(user.availableBalance)")
                            .font(.body)
                            .foregroundStyle(.green)
                        
                        Label("\(user.userLevel)", systemImage: "star.fill")
                            .foregroundStyle(.yellow)

                        Button(action: {
                            showBusinesses.toggle()
                        }) {
                            Label(showBusinesses ? "Hide Businesses" : "Show Businesses", systemImage: showBusinesses ? "chevron.up" : "chevron.down")
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                        if showBusinesses {
                            Text("Businesses Net Worth")
                                .font(.caption)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                ForEach(user.getBusinessSummaries(), id: \.self) { business in
                                    HStack(spacing: 12) {
                                        Image(systemName: business[1])
                                            .foregroundColor(getColor(business[2]))
                                        Text(business[0])
                                            .foregroundColor(getColor(business[2]))
                                        Spacer()
                                        Text("$\(business[3])")
                                            .foregroundColor(getColor(business[2]))
                                    }
                                    .padding(8)
                                    .background(getColor(business[2]).opacity(0.1))
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                }
                            }
                        }
                        
                        PortfolioSessions(selectedSession: $selectedSession)
                    }
                }
            }
            .frame(width: screenWidth-20, alignment: .leading)
            .foregroundStyle(userManager.textColor)
        }
        .scrollIndicators(.hidden)
        .padding(.top, 15)
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


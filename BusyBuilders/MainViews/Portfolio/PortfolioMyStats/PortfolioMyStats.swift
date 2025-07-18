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
                        // --- End Businesses Net Worth Section ---
                    }
                }
                
                Text("Session History: \(users.first?.sessionHistory.count ?? 0)")
                    .font(.caption)
                ScrollView (.horizontal){
                    HStack {
                        if let user = users.first{
                            ForEach(user.sessionHistory, id: \.self){ session in
                                PortfolioSessionItem(session: session)
                                    .onLongPressGesture {
                                        user.sessionHistory.removeAll(where: { $0.date == session.date })
                                    }
                                    .onTapGesture {
                                        withAnimation(.bouncy){
                                            selectedSession = session
                                        }
                                    }
                            }
                        }
                    }
                    .padding(4)
                }
                
                if let session = selectedSession {
                    PortfolioSesisonIndividualView(session: session)
                        .transition(.move(edge: .leading).combined(with: .scale))
                        .onTapGesture {
                            withAnimation(.bouncy) {
                                selectedSession = nil
                            }
                        }
                }
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(userManager.mainColor)
                    .frame(width: screenWidth-20, height: 180)
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(userManager.mainColor)
                    .frame(width: screenWidth-20, height: 180)
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(userManager.mainColor)
                    .frame(width: screenWidth-20, height: 180)
                
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

struct PortfolioSessionItem: View {
    let session : SessionDataModel
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(UserManager().textColor, lineWidth: 4)
            .frame(width: 180, height: 80)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(UserManager().textColor.opacity(0.1))
                    .frame(width: 180, height: 80)
                    .overlay {
                        VStack {
                            Text("Total: $\(session.totalBusinessIncome)")
                            Text("Total: \(session.totalTime)")
                        }
                    }
            }
    }
}

struct PortfolioSesisonIndividualView: View {
    let session : SessionDataModel
    var body: some View {
        VStack (alignment: .leading){
            Text("Session History - \(session.date.formatted())")
                .font(.caption)
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(UserManager().mainColor)
                .frame(width: screenWidth-20, height: 250)
                .overlay {
                    HStack (spacing: 10){
                        VStack (alignment: .leading){
                            Text("Income")
                                .font(.title3)
                            // Base
                            Label("$\(session.totalBusinessBaseIncome)", systemImage: "banknote")
                                .foregroundStyle(.green)
                            // Products
                            Label("$\(session.totalBusinessProductIncome)", systemImage: "shippingbox")
                                .foregroundStyle(.brown)
                            // Service
                            Label("$\(session.totalBusinessServiceIncome)", systemImage: "gearshape")
                                .foregroundStyle(.blue)
                            // Rent
                            Label("$\(session.totalBusinessRentalIncome)", systemImage: "building.2")
                                .foregroundStyle(.white)
                            
                            Spacer()
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 140, height: 2)
                            Text("$\(session.totalBusinessIncome)")
                                .font(.title3)
                        }
                        .font(.subheadline)
                        .frame(width: (screenWidth-60)/2, alignment: .leading)
                        
                        
                        VStack(alignment: .leading) {
                            Text("Costs")
                                .font(.title3)
                            // Tax
                            Label("$\(session.totalBusinessTaxCost)", systemImage: "chart.pie.fill")
                                .foregroundStyle(.red)
                            // Premises
                            Label("$\(session.totalBusinessPremisesCost)", systemImage: "building.2")
                                .foregroundStyle(.white)
                            // Employees
                            Label("$\(session.totalBusinessWageCost)", systemImage: "person.2.fill")
                                .foregroundStyle(.teal)
                            // Product Storage
                            Label("$\(session.totalBusinessProductStorageCost)", systemImage: "shippingbox.fill")
                                .foregroundStyle(.orange)
                            // Ad Campaigns
                            Label("$\(session.totalBusinessAdCampaignCost)", systemImage: "megaphone.fill")
                                .foregroundStyle(.yellow)
                            // Research
                            Label("$\(session.totalBusinessResearchCost)", systemImage: "testtube.2")
                                .foregroundStyle(.blue)
                            
                            let combinedCost = session.totalBusinessFinesCost + session.totalBusinessSecurityCost + session.totalBusinessInsuranceCost
                            Label("$\(combinedCost)", systemImage: "shield.lefthalf.filled")
                                .foregroundStyle(.gray)
                            
                            Spacer()
                            
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 140, height: 2)
                            Text("$\(session.totalBusinessCosts)")
                                .font(.title3)
                        }
                        .font(.subheadline)
                        .frame(width: (screenWidth-60)/2, alignment: .leading)
                        
                    }
                    .foregroundStyle(UserManager().textColor)
                    .frame(width: screenWidth-40, height: 210)
                }
        }
    }
}

#Preview {
    PortfolioSesisonIndividualView(session: SessionDataModel.sessionForPreview)
}

#Preview {
    Portfolio(selectedIcon: "book.pages")
        .environmentObject(UserManager())
}

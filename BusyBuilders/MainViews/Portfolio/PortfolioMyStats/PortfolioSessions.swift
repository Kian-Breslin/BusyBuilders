//
//  PorfolioSessions.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 29/07/2025.
//

import SwiftData
import SwiftUI

struct PortfolioSessions: View {
    @EnvironmentObject var userManager: UserManager
    @Query var users: [UserDataModel]
    @Binding var selectedSession : SessionDataModel?
    var body: some View {
        VStack {
            Text("Session History: \(users.first?.sessionHistory.count ?? 0)")
                .font(.caption)

            ScrollView(.horizontal) {
                HStack {
                    if let user = users.first {
                        ForEach(user.sessionHistory) { session in
                            PortfolioSessionItem(session: session)
                                .onTapGesture {
                                    print("Taz")
                                    withAnimation(.bouncy) {
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
        }
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
                            Label("$\(session.totalBusinessRentCost + session.totalBusinessBillsCost)", systemImage: "building.2")
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
    PortfolioSessions(selectedSession: .constant(SessionDataModel.sessionForPreview))
        .environmentObject(UserManager())
}

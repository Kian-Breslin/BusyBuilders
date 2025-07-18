//
//  PortfolioBusinesses.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 17/07/2025.
//

import SwiftUI
import SwiftData

struct PortfolioBusinesses: View {
    @EnvironmentObject var userManager: UserManager
    @Query var users : [UserDataModel]
    @State var openBusiness = false
    @State var selectedBusiness : BusinessDataModel? = nil
    
    var body: some View {
        ScrollView {
            VStack {
                if let user = users.first {
                    ForEach(user.businesses){ business in
                        portfolioBusinessItem(business: business)
                            .onTapGesture {
                                selectedBusiness = business
                            }
                    }
                }
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: screenWidth-20, height: 50)
                    .foregroundStyle(userManager.mainColor)
                    .overlay {
                        HStack {
                            Label("Open a new Business", systemImage: "checkmark.seal.text.page.fill")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .foregroundStyle(userManager.textColor)
                        .font(.title2)
                        .padding(.horizontal, 10)
                    }
                    .onTapGesture {
                        openBusiness.toggle()
                    }
            }
            .fullScreenCover(item: $selectedBusiness) { business in
                PortfolioBusinessIndividualView(business: business)
            }
            .fullScreenCover(isPresented: $openBusiness) {
                PortfolioCreateBusiness()
            }
        }
        .scrollIndicators(.hidden)
        .padding(.top, 15)
        .frame(width: screenWidth, height: screenHeight-240)
        .background(userManager.secondaryColor)
        .foregroundStyle(userManager.mainColor)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct portfolioBusinessItem: View {
    @EnvironmentObject var userManager: UserManager
    let business: BusinessDataModel
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: screenWidth-20, height: 100)
            .foregroundStyle(userManager.mainColor)
            .overlay {
                VStack (alignment: .leading, spacing: 5){
                    Label("\(business.businessName)", systemImage: "\(business.businessIcon)")
                        .font(.title)
                        
                    HStack {
                        Label("\(business.level)", systemImage: "star.fill")
                            .foregroundStyle(.yellow)
                            .font(.headline)
                        Label("$\(business.cashPerMinute) / min", systemImage: "banknote.fill")
                            .foregroundStyle(.green)
                            .font(.headline)
                        Label("$\(business.netWorth)", systemImage: "dollarsign.bank.building.fill")
                            .foregroundStyle(.orange)
                            .font(.headline)
                    }
                }
                .foregroundStyle(userManager.textColor)
                .frame(width: screenWidth-40, height: 100, alignment: .leading)
            }
    }
}

#Preview {
    Portfolio(selectedIcon: "building.2")
        .environmentObject(UserManager())
}

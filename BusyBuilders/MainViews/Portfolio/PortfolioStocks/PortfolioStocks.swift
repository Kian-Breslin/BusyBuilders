//
//  PortfolioStocks.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 08/08/2025.
//
import SwiftUI
import SwiftData

struct PortfolioStocks: View {
    @Query var users: [UserDataModel]
    @EnvironmentObject var userManager: UserManager
    var body: some View {
        ScrollView {
            VStack {
                if let user = users.first {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Your Stocks:")
                            .font(.headline)
                            .padding(.bottom, 10)

                        ForEach(user.stocksOwned.keys.sorted(), id: \.self) { stockName in
                            let amount = user.stocksOwned[stockName] ?? 0
                            Text("\(stockName): \(amount)")
                                .font(.body)
                                .padding(6)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(6)
                        }
                    }
                    .padding()
                }
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

#Preview {
    Portfolio(selectedIcon: "circle")
        .environmentObject(UserManager())
}

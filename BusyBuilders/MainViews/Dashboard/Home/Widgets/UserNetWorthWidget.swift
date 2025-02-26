//
//  IncomeWidget.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 19/11/2024.
//

import SwiftUI
import SwiftData

struct UserNetWorthWidget: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Query var users : [UserDataModel]
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: (screenWidth-20)/2, height: ((screenWidth - 45) / 2 - 5) / 2)
            .foregroundStyle(themeManager.mainColor)
            .overlay {
                VStack (alignment: .leading, spacing: 5){
                    HStack {
                        Text("Total Net Worth")
                            .opacity(0.7)
                    }
                    .padding(.leading, 10)
                    .font(.system(size: 15))
                    
                    if let user = users.first {
                        Text("$\(user.netWorth)")
                            .font(.system(size: 35))
                            .padding(.horizontal, 10)
                    }
                }
                .frame(width: (screenWidth-20)/2, alignment: .leading)
                .foregroundStyle(themeManager.textColor)
            }
            .onAppear {
                print("Calculating total user net worth on dashboard")
                if let user = users.first {
                    print("Before Calculations: $\(user.netWorth)")
                    // Get user balance
                    let userBalance = user.availableBalance
                    // Get total businesses net worth
                    let businessBalance = totalBusinessNetWorth(for: user)
                    // Get investments
                    let investments = 0
                    // Calculate new Net Worth
                    user.netWorth = userBalance + businessBalance + investments
                    print("After Calculations: $\(user.netWorth)")
                }
            }
    }
}

#Preview {
    UserNetWorthWidget()
        .environmentObject(ThemeManager())
}

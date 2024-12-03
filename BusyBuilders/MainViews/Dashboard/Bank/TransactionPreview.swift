//
//  Transaction.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 28/11/2024.
//

import SwiftUI

struct TransactionPreview: View {
    @EnvironmentObject var themeManager : ThemeManager
    
    let transactionAmount: Int
    let transactionDescription: String
    let transactionDate: Date
    let transactionIncome: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .frame(width: screenWidth-30, height: 80)
            .foregroundStyle(themeManager.mainColor)
            .overlay {
                HStack {
                    Image(systemName: transactionIncome ? "arrow.up" : "arrow.down")
                        .font(.title)
                        .foregroundStyle(themeManager.textColor)
                    VStack (alignment: .leading) {
                        Text("Transfer")
                            .font(.title)
                        Text("\(getDateMonthYear(from: transactionDate) ?? "")")
                            .font(.caption)
                    }
                    Spacer()
                    VStack {
                        Text("\(transactionIncome ? "+" : "-") $\(transactionAmount)")
                            .foregroundStyle(transactionIncome ? getColor("green") : getColor("red"))
                            .font(.title2)
                    }
                    
                }
                .foregroundStyle(themeManager.textColor)
                .padding(.horizontal, 10)
            }
    }
}

#Preview {
    TransactionPreview(transactionAmount: 10000, transactionDescription: "Upgrade", transactionDate: Date(), transactionIncome: false)
        .environmentObject(ThemeManager())
}

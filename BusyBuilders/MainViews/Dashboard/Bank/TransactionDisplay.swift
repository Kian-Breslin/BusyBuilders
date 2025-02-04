//
//  TransactionDisplay.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 04/02/2025.
//

import SwiftUI
import SwiftData

struct TransactionDisplay: View {
    @EnvironmentObject var themeManager : ThemeManager
    @Query var users : [UserDataModel]
    @Environment(\.modelContext) var context
    
    var body: some View {
        VStack {
            ScrollView {
                if let user = users.first {
                    VStack {
                        ForEach(user.transactions) { i in
                            transactionCard(transaction: i)
                        }
                    }
                }
            }
        }
        .onAppear {
            print(users.first?.transactions.count ?? 10101010)
        }
    }
}

struct transactionCard: View {
    @EnvironmentObject var themeManager : ThemeManager
    let transaction : TransactionDataModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: screenWidth-20, height: 80)
            .foregroundStyle(themeManager.mainColor)
            .overlay {
                HStack {
                    Image(systemName: transaction.image)
                        .font(.system(size: 35))
                    
                    VStack (alignment: .leading){
                        Text("\(transaction.transactionDescription)")
                            .bold()
                        Text("\(getDateFull(from: transaction.createdAt))")
                            .font(.system(size: 15))
                    }
                    
                    Spacer()
                    
                    Text("\(transaction.income ? "+" : "-") $\(transaction.amount)")
                        .font(.system(size: 25))
                        .foregroundStyle(transaction.income ? .green : .red)
                }
                .padding(10)
            }
            .foregroundStyle(themeManager.textColor)
    }
}

#Preview {
    
    VStack (spacing: 0){
        RoundedRectangle(cornerRadius: 0)
            .frame(width: screenWidth, height: 250)
            .foregroundStyle(ThemeManager().mainColor)
        TransactionDisplay()
            .environmentObject(ThemeManager())
    }
    .ignoresSafeArea()
}

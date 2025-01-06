//
//  Bank.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 22/11/2024.
//

import SwiftUI

struct DashboardBankView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    let mockTransactions : [TransactionDataModel] = [
        TransactionDataModel(amount: 10000, transactionDescription: "Upgrade", createdAt: Date(), income: false),
        TransactionDataModel(amount: 5000, transactionDescription: "Upgrade", createdAt: Date(), income: false),
        TransactionDataModel(amount: 30000, transactionDescription: "Transfer", createdAt: Date(), income: true),
        TransactionDataModel(amount: 12000, transactionDescription: "Upgrade", createdAt: Date(), income: false),
        TransactionDataModel(amount: 3000, transactionDescription: "Upgrade", createdAt: Date(), income: false),
        TransactionDataModel(amount: 17000, transactionDescription: "Transfer", createdAt: Date(), income: true)
    ]
    var body: some View {
        VStack {
            HStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: (screenWidth-20)/2, height: ((screenWidth - 45) / 2 - 5) / 2)
                    .foregroundStyle(themeManager.mainColor)
                    .overlay {
                        Text("Savings")
                    }
                
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: (screenWidth-20)/2, height: ((screenWidth - 45) / 2 - 5) / 2)
                    .foregroundStyle(themeManager.mainColor)
                    .overlay {
                        Text("Apply for a Loan")
                    }
            }
            HStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: (screenWidth-20)/2, height: ((screenWidth - 45) / 2 - 5) / 2)
                    .foregroundStyle(themeManager.mainColor)
                    .overlay {
                        Text("Get Credit Score")
                    }
                
                NavigationLink(destination: BankTransferView()){
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: (screenWidth-20)/2, height: ((screenWidth - 45) / 2 - 5) / 2)
                        .foregroundStyle(themeManager.mainColor)
                        .overlay {
                            Text("Transfer")
                        }
                }
            }
            .padding(.bottom, 30)
            
            VStack (alignment: .leading, spacing: 5){
                HStack {
                    Text("My Transactions")
                        .font(.system(size: 20))
                        .opacity(0.7)
                    Spacer()
                    NavigationLink(destination: MediumModularWidget()){
                        Image(systemName: "info.circle")
                            .font(.title3)
                    }
                }
                .foregroundStyle(themeManager.mainColor)
                
                ScrollView (.vertical, showsIndicators: false){
                    VStack {
                        ForEach(mockTransactions) { t in
                            TransactionPreview(transactionAmount: t.amount, transactionDescription: t.transactionDescription, transactionDate: Date(), transactionIncome: t.income)
                        }
                    }
                }
                .frame(height: 300)
                Spacer()
                
                
                
            }
            .frame(width: screenWidth-20, alignment: .leading)
        }
        .foregroundStyle(themeManager.textColor)
    }
}

#Preview {
    DashboardBankView()
        .environmentObject(ThemeManager())
}

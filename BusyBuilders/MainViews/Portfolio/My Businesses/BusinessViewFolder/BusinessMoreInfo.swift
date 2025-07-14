//
//  BusinessMoreInfo.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 03/06/2025.
//

import SwiftUI
import SwiftData

struct BusinessMoreInfo: View {
    @Query var users : [UserDataModel]
    let business : BusinessDataModel
    @State var isWithdraw = false
    @State var isAdding = false
    var body: some View {
        VStack (spacing: 20){
            Button("Withdraw"){
                isWithdraw.toggle()
            }
            
            Button("Add"){
                isAdding.toggle()
            }
            
            Button("Increase Cash / Min"){
                
            }
            
            Button("Sell Business") {
                if let user = users.first {
                    // Remove from active businesses
                    user.businesses.removeAll(where: { $0.id == business.id })
                    // Add Money to User
                    user.availableBalance += business.netWorth
                    // Add Transaction
                    let newTransaction = TransactionDataModel(amount: business.netWorth, transactionDescription: "Sold \(business.businessName)", createdAt: Date.now, income: true)
                    user.transactions.append(newTransaction)

                    // Add to sold businesses (archive)
                    user.soldBusinesses.append(business)
                    
                    print("Removed \(business.businessName)")
                    print("Number of sold businesses: \(user.soldBusinesses.count)")
                }
            }
        }
        .sheet(isPresented: $isWithdraw) {
            if let user = users.first {
                WithdrawMoneyFromBusiness(user: user, business: business, isWithdrawingMoney: $isWithdraw)
            }
        }
        .sheet(isPresented: $isAdding) {
            if let user = users.first {
                AddMoneyToBusiness(user: user, business: business, isWithdrawingMoney: $isAdding)
            }
        }
    }
}

#Preview {
    BusinessMoreInfo(business: BusinessDataModel(businessName: "Test", businessTheme: "", businessType: "", businessIcon: ""))
}

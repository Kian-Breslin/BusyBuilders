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
        VStack {
            Button("Withdraw"){
                isWithdraw.toggle()
            }
            
            Button("Add"){
                isAdding.toggle()
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

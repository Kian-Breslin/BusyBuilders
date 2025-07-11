//
//  WithdrawMoneyFromBusiness.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 12/02/2025.
//

import SwiftUI
import SwiftData

struct WithdrawMoneyFromBusiness: View {
    @EnvironmentObject var themeManager : ThemeManager
    @State var user : UserDataModel
    @State var business : BusinessDataModel
    @Binding var isWithdrawingMoney : Bool
    
    @State var amount = ""
    var body: some View {
        ZStack {
            themeManager.mainColor.ignoresSafeArea()
            
            VStack (alignment: .leading, spacing: 20){
                Text("Withdraw Cash")
                    .font(.system(size: 30))
                    .frame(width: screenWidth-20, alignment: .center)
                Text("Enter an amount to withdraw")
                
                HStack {
                    Text("$") // Dollar symbol
                        .foregroundColor(.white)
                        .opacity(amount.isEmpty ? 0.3 : 1.0) // Match input opacity

                    TextField("", text: $amount)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                        .opacity(amount.isEmpty ? 0.3 : 1.0) // Adjust opacity
                        .onChange(of: amount) { _, newValue in
                            amount = newValue.filter { $0.isNumber } // Only allow numbers
                        }
                        .overlay(
                            // Placeholder "0" when empty
                            Text(amount.isEmpty ? "0" : "")
                                .foregroundColor(.white.opacity(0.3))
                                .allowsHitTesting(false), // Prevents blocking input
                            alignment: .leading
                        )
                }
                .font(.system(size: 35))
                .cornerRadius(10)
                
                HStack {
                    Spacer()
                    Button("Withdraw") {
                        if business.netWorth >= Int(amount)!{
                            let money = (Double(amount)!)*0.9
                            business.netWorth -= Int(amount)!
                            user.availableBalance += Int(money)
                            let newTransaction = TransactionDataModel(category: "Withdraws", amount: Int(money), transactionDescription: "Withdraw from \(business.businessName)", createdAt: Date(), income: true)
                            user.transactions.append(newTransaction)
                            isWithdrawingMoney.toggle()
                            print("Amount withdrawn from \(business.businessName): $\(money)")
                        }
                    }
                    .frame(width: 150, height: 50)
                    .background(themeManager.textColor)
                    .foregroundStyle(themeManager.mainColor)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .disabled(amount == "" || amount == "0")
                    Spacer()
                }
            }
            .foregroundStyle(themeManager.textColor)
            .frame(width: screenWidth-20, height: 300, alignment: .leading)
        }
    }
}

#Preview {
    WithdrawMoneyFromBusiness(user: UserDataModel(username: "Keano517", name: "Kian Breslin", email: "Kianbreslin517@gmail.com"), business: BusinessDataModel(
        businessName: "Kians Shop",
        businessTheme: "Blue",
        businessType: "Economic",
        businessIcon: "triangle",
        owners: [UserDataModel(username: "Kian_17", name: "Kian", email: "Kianbreslin@gmail.com")],
        time: 9360,
        netWorth: 60000,
        investors: [
            UserDataModel(username: "LilKimmy", name: "Kim", email: "Kim@gmail.com"),
            UserDataModel(username: "LilJimmy", name: "Jim", email: "Jim@gmail.com"),
            UserDataModel(username: "LilLimmy", name: "Lim", email: "Lim@gmail.com"),
            UserDataModel(username: "LilPimmy", name: "Pim", email: "Pim@gmail.com"),
            UserDataModel(username: "LilTimmy", name: "Tim", email: "Tim@gmail.com"),
            UserDataModel(username: "LilRimmy", name: "Rim", email: "Rim@gmail.com")
        ],
        badges: ["10 Days Streak", "$1000 Earned", "First Upgrade"],
        sessionHistory:
            [SessionDataModel(
                id: UUID(),
                sessionDate: Date.now,
                sessionStart: formatFullDateTime(date: Date()),
                sessionEnd: formatFullDateTime(date: Date()),
                businessId: UUID(), totalStudyTime: 3600),
             SessionDataModel(
                 id: UUID(),
                 sessionDate: Date.now,
                 sessionStart: formatFullDateTime(date: Date()),
                 sessionEnd: formatFullDateTime(date: Date()),
                 businessId: UUID(), totalStudyTime: 3600)
            ],
        businessPrestige: "Growing Business"), isWithdrawingMoney: .constant(false))
        .environmentObject(ThemeManager())
}

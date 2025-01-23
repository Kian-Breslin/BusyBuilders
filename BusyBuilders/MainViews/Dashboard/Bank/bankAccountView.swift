//
//  bankAccountView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 09/01/2025.
//


import SwiftUI
import SwiftData

struct bankAccountView : View {
    @EnvironmentObject var themeManager : ThemeManager
    @State var user : UserDataModel
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [themeManager.mainColor, getColor(themeManager.mainDark)], startPoint: .top, endPoint: .bottom).ignoresSafeArea()

            VStack {
                Circle()
                    .frame(width: 80)
                    .foregroundStyle(themeManager.textColor)
                    .overlay {
                        Image("userImage-2")
                            .resizable()
                    }
                Text("\(user.name)")
                    .fontWeight(.heavy)
                    .font(.system(size: 25))
                
                Text("Account #\(user.bankAccount?.accountNumber ?? "112233")")
                
                
                
                
                Spacer()
            }
            .foregroundStyle(themeManager.textColor)
        }
//        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    bankAccountView(user: UserDataModel(username: "Keano517", name: "Kian Breslin", email: "kianbreslin@gmail.com", bank: BankDataModel(name: "Ace Bank", icon: "suit.spade", loanInterestRate: 0.05, savingsInterestRate: 0.05, benefits: [])))
        .environmentObject(ThemeManager())
}

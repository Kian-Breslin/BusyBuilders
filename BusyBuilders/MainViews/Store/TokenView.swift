//
//  TokenView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 11/07/2025.
//

import SwiftUI
import SwiftData

struct TokenView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @Environment(\.modelContext) var context
    @Query var users: [UserDataModel]
    
    @State var noMoneyAlert = false
    
    var body: some View {
        if let user = users.first {
            VStack {
                
                Text("Current Tokens: \(user.tokens)")
                
                Text("Token Cost: $10,000")
                
                Button("Buy Token"){
                    if user.availableBalance >= 10000 {
                        user.tokens += 1
                        user.availableBalance -= 10000
                    } else {
                        print("Not Enough Money")
                        noMoneyAlert.toggle()
                    }
                }
                .frame(width: 180, height: 50)
                .background(themeManager.mainColor)
                .foregroundStyle(themeManager.textColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .font(.system(size: 30))
                
                Button("Buy 10"){
                    user.tokens += 10
                }
                .frame(width: 180, height: 50)
                .background(themeManager.mainColor)
                .foregroundStyle(themeManager.textColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .font(.system(size: 30))
                
            }
            .foregroundStyle(themeManager.textColor)
            .font(.system(size: 30))
            .alert("Not Enough Money", isPresented: $noMoneyAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("You dont have enough Money. Do a session to earn more!")
            }
        }
    }
}

#Preview {
    ZStack{
        getColor(ThemeManager().mainDark).ignoresSafeArea()
        TokenView()
            .environmentObject(ThemeManager())
    }
}

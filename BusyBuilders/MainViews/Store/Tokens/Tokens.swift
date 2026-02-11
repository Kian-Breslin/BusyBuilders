//
//  Tokens.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 10/02/2026.
//

import SwiftUI
import SwiftData

struct Tokens: View {
    @EnvironmentObject var userManager: UserManager
    @Query var users: [UserDataModel]
    @Environment(\.modelContext) var context
    
    var body: some View {
        ScrollView {
            VStack (spacing: 10){
                if let user = users.first {
                    Text("Available Balance: $\(user.availableBalance)")
                    Text("Tokens: \(user.tokens)")
                } else {
                    Text("Available Balance: $400,000")
                    Text("Tokens: 9")
                }
                
                Spacer()
                
                customButton(text: "Buy Token", color: getColor(userManager.accentColor), width: 150, height: 50) {
                    if let user = users.first {
                        if user.availableBalance >= 5000{
                            user.tokens += 1
                            user.availableBalance -= 5000
                        }
                        do {
                            try context.save()
                        } catch {
                            print("Failed to save context: \(error)")
                        }
                    }
                }
            }
            .foregroundStyle(userManager.textColor)
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
    Tokens()
        .environmentObject(UserManager())
}


//
//  PortfolioMyStats.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 17/07/2025.
//

import SwiftUI
import SwiftData

struct PortfolioMyStats: View {
    @EnvironmentObject var userManager: UserManager
    @Query var users : [UserDataModel]
    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 10){
                Text("Session History: \(users.first?.sessionHistory.count ?? 0)")
                    .font(.caption)
                ScrollView (.horizontal){
                    HStack {
                        if let user = users.first{
                            ForEach(user.sessionHistory, id: \.self){ session in
                                PortfolioSessionItem(session: session)
                                    .onLongPressGesture {
                                        user.sessionHistory.removeAll(where: { $0.date == session.date })
                                    }
                            }
                        }
                    }
                    .padding(4)
                }
            }
            .frame(width: screenWidth-20, alignment: .leading)
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

struct PortfolioSessionItem: View {
    let session : SessionDataModel
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(UserManager().textColor, lineWidth: 4)
            .frame(width: 180, height: 80)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(UserManager().textColor.opacity(0.1))
                    .frame(width: 180, height: 80)
                    .overlay {
                        VStack {
                            Text("Total: $\(session.totalBusinessIncome)")
                            Text("Total: \(session.totalTime)")
                        }
                    }
            }
    }
}

#Preview {
    Portfolio(selectedIcon: "book.pages")
        .environmentObject(UserManager())
}

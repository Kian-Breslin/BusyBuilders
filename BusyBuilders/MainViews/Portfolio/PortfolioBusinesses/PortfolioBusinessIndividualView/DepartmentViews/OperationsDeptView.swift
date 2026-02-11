//
//  OperationsDeptView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 22/07/2025.
//
import SwiftUI
import SwiftData

struct OperationsDeptView: View {
    @Query var users: [UserDataModel]
    let business: BusinessDataModel
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Label("Level: \(business.departments["Operations Department"]?.level ?? 0) / 30", systemImage: "star.fill")
                    Label("$5,000", systemImage: "chevron.up")
                        .foregroundStyle(.green)
                }
                Spacer()
                customButton(text: "Upgrade", color: getColor(business.businessTheme), width: 150, height: 50, action: {
                    if let user = users.first, user.availableBalance >= 5000 {
                        user.availableBalance -= 5000
                        business.upgradeDepartment(dept: "Operations Department")
                    }
                })
            }
            .padding(.top, 10)
            HStack {
                VStack(alignment: .leading) {
                    Label("Premises Capacity: \(business.employees * 2)", systemImage: "building")
                    Label("Upgrade Cost: $250,000", systemImage: "banknote")
                }
                Spacer()
                customButton(text: "Upgrade Premises", color: getColor(business.businessTheme), width: 150, height: 50, action: {})
            }
            Spacer()
        }
        .frame(width: screenWidth-40, height: 200, alignment: .leading)
        .padding(.top, 10)
    }
}

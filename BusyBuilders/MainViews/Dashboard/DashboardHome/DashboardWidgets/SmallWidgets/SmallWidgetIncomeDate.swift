//
//  SmallWidgetIncomeDate.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 28/07/2025.
//

import SwiftUI
import SwiftData

struct SmallWidgetIncomeDate: View {
    @Query var users: [UserDataModel]
    @EnvironmentObject var userManager: UserManager
    let widgetSize = smallWidgetSize
    @State var date = "Todays"
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: widgetSize.width, height: widgetSize.height)
            .foregroundStyle(userManager.mainColor)
            .overlay {
                VStack (alignment: .leading, spacing: 10){
                    Text("\(date) Income")
                    if let user = users.first {
                        Text("$\(user.getDateIncome(date: "\(date)"))")
                            .font(.title)
                    } else {
                        Text("$100,000")
                            .font(.title)
                    }
                }
                .frame(width: widgetSize.width-20, height: widgetSize.height-20, alignment: .leading)
                .foregroundStyle(userManager.textColor)
                .onTapGesture {
                    if date == "Todays" {
                        date = "Weekly"
                    } else if date == "Weekly" {
                        date = "Monthly"
                    } else {
                        date = "Todays"
                    }
                }
            }
    }
}

#Preview {
    SmallWidgetIncomeDate()
        .environmentObject(UserManager())
}

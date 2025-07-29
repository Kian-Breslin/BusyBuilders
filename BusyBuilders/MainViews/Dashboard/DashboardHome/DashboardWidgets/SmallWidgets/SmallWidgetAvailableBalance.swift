//
//  SmallWidget.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 28/07/2025.
//

import SwiftUI
import SwiftData

struct SmallWidgetAvailableBalance: View {
    @Query var users: [UserDataModel]
    @EnvironmentObject var userManager: UserManager
    let widgetSize = smallWidgetSize
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: widgetSize.width, height: widgetSize.height)
            .foregroundStyle(userManager.mainColor)
            .overlay {
                VStack (alignment: .leading, spacing: 10){
                    Text("Available Balance:")
                    if let user = users.first {
                        Text("$\(user.availableBalance)")
                            .font(.title)
                    } else {
                        Text("$100,000")
                            .font(.title)
                    }
                }
                .frame(width: widgetSize.width-10, height: 70, alignment: .leading)
                .foregroundStyle(userManager.textColor)
            }
    }
}

#Preview {
    SmallWidgetAvailableBalance()
        .environmentObject(UserManager())
}

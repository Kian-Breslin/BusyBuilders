//
//  MediumRandomBusiness.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 27/01/2026.
//

import SwiftUI
import SwiftData

struct MediumRandomBusiness: View {
    @Query var users: [UserDataModel]
    @EnvironmentObject var userManager: UserManager
    let widgetSize = small1x4WidgetSize
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: widgetSize.width, height: widgetSize.height)
            .foregroundStyle(userManager.mainColor)
            .overlay {
                if let user = users.first {
                    let business = user.getRandomBusiness()
                    HStack {
                        VStack {
                            Text("Business Name: \(business?.businessName ?? "No Business Found")")
                        }
                    }
                }
            }
    }
}

#Preview {
    MediumRandomBusiness()
        .environmentObject(UserManager())
}

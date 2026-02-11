//
//  MiniWidgetActiveBusinesses.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 13/08/2025.
//

import SwiftUI
import SwiftData

struct MiniWidgetActiveBusinesses: View {
    @EnvironmentObject var userManager: UserManager
    let widgetSize = miniWidgetSize
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: widgetSize.width, height: widgetSize.height)
            .foregroundStyle(userManager.mainColor)
            .overlay {
                VStack(spacing: 2) {
                    Image(systemName: "building.2.fill")
                        .font(.system(size: 24))
                        .foregroundStyle(getColor(userManager.accentColor))
                    Text("7")
                        .font(.system(size: 24, weight: .bold))
                }
                .foregroundStyle(userManager.textColor)
            }
    }
}

#Preview {
    MiniWidgetActiveBusinesses()
        .environmentObject(UserManager())
}

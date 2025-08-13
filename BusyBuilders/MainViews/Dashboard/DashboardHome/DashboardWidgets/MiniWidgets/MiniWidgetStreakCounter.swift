//
//  MiniWidgetStreakCounter.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 13/08/2025.
//

import SwiftUI
import SwiftData

struct MiniWidgetStreakCounter: View {
    @EnvironmentObject var userManager: UserManager
    let widgetSize = miniWidgetSize
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: widgetSize.width, height: widgetSize.height)
            .foregroundStyle(userManager.mainColor)
            .overlay {
                VStack(spacing: 2) {
                    HStack(spacing: 4) {
                        Text("330")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                        Image(systemName: "flame.fill")
                            .font(.system(size: 18))
                            .foregroundStyle(getColor(userManager.accentColor))
                    }
                    .foregroundStyle(userManager.textColor)
                    
                    Text("Days")
                        .font(.system(size: 10))
                        .foregroundStyle(userManager.textColor)
                }
            }
    }
}

#Preview {
    MiniWidgetStreakCounter()
        .environmentObject(UserManager())
}

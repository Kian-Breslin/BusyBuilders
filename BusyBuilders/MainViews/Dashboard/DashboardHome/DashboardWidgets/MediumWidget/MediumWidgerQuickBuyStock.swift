//
//  MediumWidgetQuickBusinessView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 13/08/2025.
//

import SwiftUI
import SwiftData

struct MediumWidgerQuickBuyStock: View {
    @EnvironmentObject var userManager: UserManager
    let widgetSize = small1x4WidgetSize
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: widgetSize.width, height: widgetSize.height)
            .foregroundStyle(userManager.mainColor)
            .overlay {
                HStack (alignment: .top){
                    Image(systemName: "wrench")
                        .font(.largeTitle)
                        .foregroundStyle(getColor(userManager.accentColor))
                    
                    VStack (alignment: .leading){
                        Text("TokTik")
                            .font(.title2)
                        Text("$65.50")
                    }
                    Spacer()
                    Text("Refresh: \n54 mins")
                        .font(.caption)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 100, height: 50)
                        .shadow(color: userManager.secondaryColor, radius: 5, x: 0, y: 0)
                        .padding(.horizontal, 10)
                        .foregroundStyle(.green)
                        .overlay {
                            Label("Buy", systemImage: "cart.fill")
                                .font(.title2)
                                .bold()
                        }
                }
                .foregroundStyle(userManager.textColor)
                .padding(10)
            }
    }
}

#Preview {
    MediumWidgerQuickBuyStock()
        .environmentObject(UserManager())
}

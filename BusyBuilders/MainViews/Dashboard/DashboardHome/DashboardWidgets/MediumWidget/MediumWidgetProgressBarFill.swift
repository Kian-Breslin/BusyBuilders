//
//  MediumWidgetProgressBarFill.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 13/08/2025.
//

import SwiftUI
import SwiftData

struct MediumWidgetProgressBarFill: View {
    @EnvironmentObject var userManager: UserManager
    let widgetSize = small1x4WidgetSize
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: widgetSize.width, height: widgetSize.height)
            .foregroundStyle(userManager.mainColor)
            .overlay (alignment: .leading){
                RoundedRectangle(cornerRadius: 5)
                    .foregroundStyle(.red)
                    .frame(width: widgetSize.width-20, height: 70)
                    .padding(10)
                    .overlay {
                        Text("85% Complete")
                    }
            }
    }
}

#Preview {
    MediumWidgetProgressBarFill()
        .environmentObject(UserManager())
}

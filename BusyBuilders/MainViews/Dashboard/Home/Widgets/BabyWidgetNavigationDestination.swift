//
//  BabyWidgetNavigationDestination.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 04/03/2025.
//

import Foundation
import SwiftUI
import SwiftData

struct BabyWidgetNavigationDestination: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @State var widgetTitle: String
    
    var body: some View {
        ZStack {
            themeManager.mainColor.ignoresSafeArea()
            VStack {
                Text(widgetTitle)
                    .font(.system(size: 30))
                
                
                
                
                Spacer()
            }
                .foregroundStyle(themeManager.textColor)
        }
    }
}

#Preview {
    BabyWidgetNavigationDestination(widgetTitle: "Best in the World")
        .environmentObject(ThemeManager())
}

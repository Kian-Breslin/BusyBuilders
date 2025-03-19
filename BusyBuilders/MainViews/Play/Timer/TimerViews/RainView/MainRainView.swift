//
//  MainRainView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 05/03/2025.
//

import SwiftUI

struct MainRainView: View {
    @EnvironmentObject var themeManager : ThemeManager
        
    var body: some View {
        ZStack {
            RainTimer()
            
            VStack {
                Text("Business Name")
                    .font(.system(size: 40))
                    .foregroundStyle(themeManager.textColor)
                
                
            }
        }
    }
}

#Preview {
    MainRainView()
        .environmentObject(ThemeManager())
}

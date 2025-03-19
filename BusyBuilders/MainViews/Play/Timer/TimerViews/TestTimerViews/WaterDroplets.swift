//
//  WaterDroplets.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 05/03/2025.
//

import SwiftUI

struct WaterDroplets: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @State var circleSize = 80
    @State var circleOpacity = 1.0
    var body: some View {
        ZStack {
            themeManager.mainColor.ignoresSafeArea()
            
            Circle()
                .stroke(lineWidth: 3)
                .frame(width: CGFloat(circleSize))
                .foregroundStyle(themeManager.textColor)
                .opacity(circleOpacity)
            
            Circle()
                .stroke(lineWidth: 3)
                .frame(width: CGFloat(circleSize/2))
                .foregroundStyle(themeManager.textColor)
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
                circleSize += 1
                if circleSize > 90 {
                    withAnimation(.linear){
                        circleOpacity = 0
                    }
                }
            }
        }
    }
}

#Preview {
    WaterDroplets()
        .environmentObject(ThemeManager())
}

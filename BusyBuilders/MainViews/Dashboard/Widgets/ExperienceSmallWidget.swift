//
//  ExperienceSmallWidget.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 19/11/2024.
//

import SwiftUI

struct ExperienceSmallWidget: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: (screenWidth-45)/2, height: 100)
            .foregroundStyle(themeManager.mainColor)
            .overlay {
                VStack (spacing: 10){
                    HStack {
                        Image(systemName: "star")
                            .font(.system(size: 20))
                        Spacer()
                        Text("7")
                            .font(.system(size: 20))
                            .bold()
                            .frame(width: ((screenWidth-45)/2)/2)
                        Spacer()
                        Image(systemName: "arrow.down.right.circle")
                            .font(.system(size: 20))
                            .foregroundStyle(Color.red)
                    }
                    .padding(.horizontal, 5)
                    
                    HStack {
                        Text("Levels Today")
                            .font(.system(size: 15))
                            .opacity(0.7)
                        
                        Text("-1.8%")
                            .font(.system(size: 15))
                            .foregroundStyle(Color.red)
                    }
                }
                .foregroundStyle(themeManager.textColor)
            }
    }
}

#Preview {
    ExperienceSmallWidget()
        .environmentObject(ThemeManager())
}

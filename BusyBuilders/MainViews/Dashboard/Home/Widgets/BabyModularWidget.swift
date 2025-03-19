//
//  BabyModularWidget.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 21/11/2024.
//

import SwiftUI

struct BabyModularWidget: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @State var numberDisplay : Int
    let randomImages = ["globe.americas", "sun.min", "moon", "lizard"]
    @State var isTaskActive = false
    @State var isTimerActive = false
    @State var isSettingsShowing = false
    
    
    var body: some View {
//        RoundedRectangle(cornerRadius: 10)
//            .foregroundStyle(themeManager.mainColor)
//            .frame(width: ((screenWidth - 25) / 2 - 5) / 2, height: ((screenWidth - 45) / 2 - 5) / 2)
//            .overlay {
//                Text("\(numberDisplay)")
//                    .font(.system(size: 40))
//                    .bold()
//                    .foregroundStyle(getColor("\(themeManager.secondaryColor)"))
//            }

            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(themeManager.mainColor)
                .frame(width: ((screenWidth - 25) / 2 - 5) / 2, height: ((screenWidth - 45) / 2 - 5) / 2)
                .overlay {
                    Image(systemName: randomImages[numberDisplay])
                        .font(.system(size: 50))
                        .foregroundStyle(getColor("\(themeManager.secondaryColor)"))
                }
    }
}

#Preview {
    BabyModularWidget(numberDisplay: 3)
        .environmentObject(ThemeManager())
}

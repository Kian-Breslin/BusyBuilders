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
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .foregroundStyle(themeManager.mainColor)
            .frame(width: ((screenWidth - 35) / 2 - 5) / 2, height: ((screenWidth - 45) / 2 - 5) / 2)
            .overlay {
                Text("\(numberDisplay)")
                    .font(.system(size: 40))
                    .bold()
                    .foregroundStyle(getColor("\(themeManager.secondaryColor)"))
            }
    }
}

#Preview {
    BabyModularWidget(numberDisplay: 1)
        .environmentObject(ThemeManager())
}

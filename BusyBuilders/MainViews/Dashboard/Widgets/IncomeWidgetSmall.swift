//
//  IncomeWidget.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 19/11/2024.
//

import SwiftUI

struct IncomeWidgetSmall: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: (screenWidth-45)/2, height: 100)
            .foregroundStyle(themeManager.mainColor)
            .overlay {
                VStack (spacing: 10){
                    HStack {
                        Image(systemName: "banknote")
                            .font(.system(size: 20))
                        Spacer()
                        Text("$130,950")
                            .font(.system(size: 20))
                            .bold()
                            .frame(width: ((screenWidth-45)/2)/2)
                        Spacer()
                        Image(systemName: "arrow.up.right.circle")
                            .font(.system(size: 20))
                            .foregroundStyle(getColor("\(themeManager.secondaryColor)"))
                    }
                    .padding(.horizontal, 5)
                    
                    HStack {
                        Text("Income Today")
                            .font(.system(size: 15))
                            .opacity(0.7)
                        
                        Text("+20.3%")
                            .font(.system(size: 15))
                            .foregroundStyle(getColor("\(themeManager.secondaryColor)"))
                    }
                }
                .foregroundStyle(themeManager.textColor)
            }
    }
}

#Preview {
    IncomeWidgetSmall()
        .environmentObject(ThemeManager())
}

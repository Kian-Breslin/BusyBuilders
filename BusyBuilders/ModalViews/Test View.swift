//
//  Test View.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 07/11/2024.
//

import SwiftUI

struct Test_View: View {
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 300, height: 100)
            .foregroundStyle(themeManager.mainColor)
            .overlay{
                Text("This text should be white")
                    .foregroundStyle(themeManager.textColor)
            }
        
    }
}

#Preview {
    Test_View()
        .environmentObject(ThemeManager())
}

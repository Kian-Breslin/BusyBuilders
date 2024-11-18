//
//  Communities.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 23/09/2024.
//

import SwiftUI

struct Communities: View {
    
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        ZStack {
            getColor("Black")
                .ignoresSafeArea()
            
            Test_View(mainColor: themeManager.mainColor, secondaryColor: getColor(themeManager.secondaryColor), textColor: themeManager.textColor)
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    Communities()
        .modelContainer(for: UserDataModel.self)
        .environmentObject(ThemeManager())
}

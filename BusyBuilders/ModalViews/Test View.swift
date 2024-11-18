//
//  Test View.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 07/11/2024.
//

import SwiftUI

struct Test_View: View {
    
    @State var mainColor : Color
    @State var secondaryColor: Color
    @State var textColor: Color

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 300, height: 100)
            .foregroundStyle(mainColor)
            .overlay{
                Text("This text should be white")
                    .foregroundStyle(textColor)
            }
        
    }
}

#Preview {
    Test_View(mainColor: getColor("black"), secondaryColor: getColor("red"), textColor: getColor("white"))
        .environmentObject(ThemeManager())
}

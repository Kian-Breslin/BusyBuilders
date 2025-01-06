//
//  Slots.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 02/12/2024.
//

import SwiftUI

struct Slots: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @Binding var isTaskActive : Bool
    
    @State var arrayItems1 = getRandomToolsArray()
    @State var arrayItems2 = getRandomToolsArray()
    @State var arrayItems3 = getRandomToolsArray()
    
    @State var winningItems : [String] = ["","",""]
    @State var offsetValue = -205
    
    var body: some View {
        ZStack {
            themeManager.mainColor.ignoresSafeArea()
            
            VStack (spacing: 100){
                HStack {
                    Text("Slots")
                        .font(.largeTitle)
                    
                    Spacer()
                    
                    Image(systemName: "info.circle")
                        .font(.title2)
                }
                SlotMachine(isGameActive: $isTaskActive)
                Spacer()
            }
            .frame(width: screenWidth-20)
        }
        .foregroundStyle(themeManager.textColor)
    }
}

#Preview {
    Slots(isTaskActive: .constant(true))
        .environmentObject(ThemeManager())
}

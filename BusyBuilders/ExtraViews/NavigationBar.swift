//
//  NavigationBar.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 23/09/2024.
//

import SwiftUI

struct NavigationBar: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var iconListSelected = ["square.grid.2x2.fill", "person.2.fill", "play.fill", "cart.fill", "person.fill"]
    var iconListNotSelected = ["square.grid.2x2", "person.2", "play", "cart", "person"]
    var iconListName = ["Dashboard", "Communities", "Start", "Store", "Portfolio"]
    
    @Binding var selectedView : Int
    
    var body: some View {
        ZStack (alignment: .top){
            Rectangle()
                .frame(width: screenWidth, height: 75)
                .foregroundStyle(themeManager.textColor)
            
            HStack (alignment: .top ,spacing: 15){
                ForEach(0 ..< 5) { i in
                    ZStack {
                        if selectedView == i {
                            Image(systemName: "\(iconListSelected[i])")
                                .foregroundStyle(themeManager.mainColor)
                        } else {
                            Image(systemName: "\(iconListNotSelected[i])")
                                .foregroundStyle(themeManager.mainColor)
                        }
                        Text("\(iconListName[i])")
                            .font(.system(size: 10))
                            .offset(y:25)
                            .opacity(0)
                    }
                    .frame(width: 65, height: 60)
                    .onTapGesture {
                        selectedView = i
                    }
                }
            }
            .font(.system(size: 24))
            .fontWeight(.light)
        }
        .animation(.linear, value: selectedView)
        .sensoryFeedback(.impact(flexibility: .soft, intensity: 50), trigger: selectedView)
    }
}

#Preview {
    NavigationBar(selectedView: .constant(0))
        .environmentObject(ThemeManager())
}

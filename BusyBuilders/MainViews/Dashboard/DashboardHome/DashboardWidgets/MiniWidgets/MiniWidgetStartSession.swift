//
//  MiniWidgetStartSession.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 28/07/2025.
//
import SwiftUI
import SwiftData

struct MiniWidgetStartSession: View {
    @Query var users: [UserDataModel]
    @EnvironmentObject var userManager: UserManager
    let widgetSize = miniWidgetSize
    @Binding var quickStartSession: Bool
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
           .frame(width: widgetSize.width, height: widgetSize.height)
           .foregroundStyle(userManager.mainColor)
           .overlay {
               VStack(spacing: 4) {
                   Image(systemName: "play.circle.fill")
                       .font(.system(size: 28))
                       .foregroundStyle(getColor(userManager.accentColor))
                   
                   Text("Focus")
                       .font(.system(size: 10, weight: .medium))
                       .foregroundStyle(userManager.textColor.opacity(0.8))
               }
           }
           .onTapGesture {
               userManager.quickStartSession = true
           }
           .contextMenu {
               Button {
                   userManager.quickSessionScreen = "Beach"
                   userManager.quickStartSession.toggle()
                   
               } label: {
                   Label("Beach Timer", systemImage: "beach.umbrella")
               }
               Button {
                   userManager.quickSessionScreen = "Lighthouse"
                   userManager.quickStartSession.toggle()
                   
               } label: {
                   Label("Light House Timer", systemImage: "house")
               }
               
               Button {
                   userManager.quickSessionScreen = "Sunset"
                   userManager.quickStartSession.toggle()
                   
               } label: {
                   Label("Sunset Timer", systemImage: "sun.haze.fill")
               }
               
               Button {
                   userManager.quickSessionScreen = "Red Mountains"
                   userManager.quickStartSession.toggle()
                   
               } label: {
                   Label("Red Mountain", systemImage: "mountain.2")
               }
           }
    }
}

#Preview {
    MiniWidgetStartSession(quickStartSession: .constant(false))
        .environmentObject(UserManager())
}

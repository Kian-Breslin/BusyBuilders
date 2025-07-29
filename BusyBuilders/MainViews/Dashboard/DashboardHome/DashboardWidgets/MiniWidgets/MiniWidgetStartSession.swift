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
                Image(systemName: "play")
                    .font(.largeTitle)
                    .foregroundStyle(userManager.textColor)
            }
            .onTapGesture {
                userManager.quickStartSession = true
            }
    }
}

#Preview {
    MiniWidgetStartSession(quickStartSession: .constant(false))
        .environmentObject(UserManager())
}

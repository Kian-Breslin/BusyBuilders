//
//  SocialMessages.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 17/07/2025.
//

import SwiftUI
import SwiftData

struct SocialMessages: View {
    @EnvironmentObject var userManager: UserManager
    var body: some View {
        ScrollView {
            VStack (spacing: 10){
                Text("Placeholder")
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 100, height: 100)
            }
        }
        .scrollIndicators(.hidden)
        .padding(.top, 15)
        .frame(width: screenWidth, height: screenHeight-240)
        .background(userManager.secondaryColor)
        .foregroundStyle(userManager.mainColor)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    Social()
        .environmentObject(UserManager())
}

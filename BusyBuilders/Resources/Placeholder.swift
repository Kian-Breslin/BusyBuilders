//
//  Placeholder.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 30/07/2025.
//

import SwiftUI
import SwiftData

struct Placeholder: View {
    @EnvironmentObject var userManager: UserManager
    var body: some View {
        ScrollView {
            VStack {
                Text("Placeholder")
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
    Placeholder()
        .environmentObject(UserManager())
}

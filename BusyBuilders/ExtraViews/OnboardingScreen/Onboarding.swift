//
//  Onboarding.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 19/11/2024.
//

import SwiftUI

struct Onboarding: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var userManager: UserManager
    
    @State var currentScreen = 0
    
    var body: some View {
        if currentScreen == 0 {
            OnboardingStart(currentScreen: $currentScreen)
        }
        else if currentScreen == 1 {
            OnboardingInfo(currentScreen: $currentScreen)
        }
        else if currentScreen == 2 {
            OnboardingUserInfo(currentScreen: $currentScreen)
        }
        else if currentScreen == 3 {
            OnboardingEnd(currentScreen: $currentScreen)
        }
    }
}

#Preview {
    Onboarding()
        .environmentObject(ThemeManager())
        .environmentObject(UserManager())
}

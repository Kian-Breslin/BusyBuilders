//
//  OnboardingInformation.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 29/12/2025.
//

import SwiftUI

struct OnboardingInformation: View {
    @EnvironmentObject var userManager: UserManager
    
    @State var moveHeroSection = false
    
    var body: some View {
        ZStack {
            userManager.mainColor.ignoresSafeArea()
            
            VStack {
                VStack {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .font(.system(size: 150))
                        .foregroundStyle(getColor(userManager.accentColor).gradient)
                        .padding(.bottom, 15)
                    
                    
                    
                    Text("Your Focus, Supercharged:")
                        .bold()
                        .kerning(1.5)
                        .font(.title3)
                    (Text("Gain ") + Text("30% More").bold().foregroundStyle(getColor(userManager.accentColor)) + Text(" Results"))
                        .opacity(0.8)
                        .font(.largeTitle)
                }
                .offset(y: moveHeroSection ? -50 : 0)
                
                Text("Teams using goals, points, and streaks often see 20–30% higher task completion, with progress feedback boosting engagement by about 25%.")
                    .frame(width: screenWidth-20)
                    .multilineTextAlignment(.center)
                    .opacity(moveHeroSection ? 1 : 0)
            }
        }
        .foregroundStyle(userManager.textColor)
        .onAppear {
            withAnimation(.linear(duration: 0.8)) {
                moveHeroSection.toggle()
            }
        }
    }
}

#Preview {
    OnboardingInformation()
        .environmentObject(UserManager())
}


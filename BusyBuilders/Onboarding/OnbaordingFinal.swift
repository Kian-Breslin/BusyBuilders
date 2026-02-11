//
//  OnbaordingFinal.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 02/01/2026.
//
import SwiftUI

struct OnboardingFinal: View {
    @EnvironmentObject var userManager: UserManager
    @State var moveHeroSection = false
    
    var body: some View {
        ZStack {
            userManager.mainColor.ignoresSafeArea()
            
            VStack {
                VStack {
                    Image(systemName: "checkmark.circle")
                        .font(.system(size: 150))
                        .foregroundStyle(getColor(userManager.accentColor).gradient)
                        .padding(.bottom, 15)
                    
                    
                    
                    Text("Congratulations!")
                        .bold()
                        .kerning(1.5)
                        .font(.title3)
                    (Text("You've ") + Text("made the first ").bold().foregroundStyle(getColor(userManager.accentColor)) + Text("step!"))
                        .opacity(0.8)
                        .font(.title)
                }
                .offset(y: moveHeroSection ? -50 : 0)
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
    OnboardingFinal()
        .environmentObject(UserManager())
}

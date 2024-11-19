//
//  OnboardingScreen.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 18/11/2024.
//

import SwiftUI

struct OnboardingStart: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var currentScreen : Int
    // Hammer Animation
    @State var isHammerAnimating = false
    let timer = Timer.publish(every: 2.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            themeManager.mainColor
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                ZStack {
                    Text("BusyBuilders")
                        .font(.system(size: 40))
                        .offset(x: -20)
                        .foregroundStyle(themeManager.textColor)
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 320, height: 50)
                        .foregroundStyle(themeManager.mainColor)
                        .offset(x: isHammerAnimating ? 250 : 0)
                    
                    Image("Hammer")
                        .resizable()
                        .foregroundStyle(themeManager.textColor)
                        .frame(width: 50, height: 50)
                        .offset(x: isHammerAnimating ? 120 : -120)
                }
                Spacer()
                RoundedRectangle(cornerRadius: 30)
                    .frame(width: screenWidth-60, height: 60)
                    .foregroundStyle(themeManager.textColor)
                    .overlay {
                        Text("Get Started")
                            .foregroundStyle(themeManager.mainColor)
                            .font(.system(size: 20))
                    }
                    .onTapGesture {
                        currentScreen += 1
                    }
            }
            
        }
        .animation(.bouncy(duration: 2.5), value: isHammerAnimating)
        .onAppear {
            isHammerAnimating.toggle()
        }
        .onReceive(timer) { time in
            isHammerAnimating.toggle()
        }
    }
}

#Preview {
    OnboardingStart(currentScreen: .constant(0))
        .environmentObject(ThemeManager())
}

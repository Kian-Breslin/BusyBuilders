//
//  OnboardingIntro.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 29/12/2025.
//

import SwiftUI

struct OnboardingIntro: View {
    @EnvironmentObject var userManager: UserManager
    
    @State var isSelected = false
    var body: some View {
        ZStack {
            userManager.mainColor.ignoresSafeArea()
            
            VStack {
                if isSelected == true {
                    Image("garageBuilding")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .foregroundStyle(.black)
                        .transition(.scale)
                        .onTapGesture {
                            withAnimation(.linear){
                                isSelected.toggle()
                            }
                        }
                } else {
                    Image("\(userManager.isDarkMode ? "Hammer" : "HammerBlack")")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .foregroundStyle(.black)
                        .transition(.scale)
                        .onTapGesture {
                            withAnimation(.linear){
                                isSelected.toggle()
                            }
                        }
                }
                
                Text("Welcome to BusyBuilders")
                    .bold()
                    .kerning(1.5)
                    .font(.title3)
                Text("Manage your time and earn rewards, grow your empire!")
                    .opacity(0.8)
                    .font(.subheadline)
                    .frame(width: 180)
                    .multilineTextAlignment(.center)
                    .padding(.top, 5)
            }
            
            VStack {
                Spacer()
                
                
            }
        }
        .foregroundStyle(userManager.textColor)
    }
}

#Preview {
    OnboardingIntro()
        .environmentObject(UserManager())
}

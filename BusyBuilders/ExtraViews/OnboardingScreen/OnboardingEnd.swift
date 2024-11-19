//
//  OnboardingEnd.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 19/11/2024.
//

import SwiftUI
import SwiftData

struct OnboardingEnd: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var userManager: UserManager
    @Query var users: [UserDataModel]
    
    @Binding var currentScreen : Int
    @State var load = false
    
    var body: some View {
        ZStack {
            themeManager.mainColor
                .ignoresSafeArea()
            
            VStack (spacing: 15){
                
                HStack (alignment: .bottom){
                    Text("Thank You,")
                        .font(.system(size: 25))
                    
                    Text("\(users.first?.username ?? "Kimmy")")
                        .font(.system(size: 30))
                        .foregroundStyle(getColor(themeManager.secondaryColor))
                }
                
                Text("You've completed the set-up")
                Text("Click the button to Start Earning!")
                
                Spacer()
                HStack {
                    Spacer()
                    Circle()
                        .frame(width: 70, height: 70)
                        .padding()
                        .overlay {
                            Circle()
                                .trim(from: 0, to: load ? 1 : 0.66)
                                .stroke(lineWidth: 5)
                                .rotationEffect(Angle(degrees: -90))
                                .frame(width: 75, height: 75)
                                .foregroundStyle(getColor(themeManager.secondaryColor))
                            Image(systemName: "checkmark")
                                .font(.system(size: 30))
                                .foregroundStyle(themeManager.mainColor)
                                .bold()
                        }
                }
                .animation(.linear(duration: 1), value: load)
                .onAppear {
                    load.toggle()
                }
                .onTapGesture {
                    currentScreen += 1
                    userManager.isUserCreated = true
                }
            }
            
        }
        .foregroundStyle(themeManager.textColor)
    }
}

#Preview {
    OnboardingEnd(currentScreen: .constant(0))
        .environmentObject(ThemeManager())
        .environmentObject(UserManager())
}

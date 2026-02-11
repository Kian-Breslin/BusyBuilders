//
//  OnboardingMain.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 29/12/2025.
//

import SwiftUI
import SwiftData

struct OnboardingMain: View {
    @Environment(\.modelContext) var context
    @Query var users : [UserDataModel]
    @EnvironmentObject var userManager: UserManager
    @State var selectedView = 0
    
    @State var name: String = ""
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var isSigned: Bool = false
    
    var body: some View {
        ZStack {
            userManager.mainColor.ignoresSafeArea()
            if selectedView == 0 {
                OnboardingIntro()
                    .transition(.slide)
            }
            else if selectedView == 1 {
                OnboardingInformation()
            }
            else if selectedView == 2 {
                OnboardingUserInfo(name: $name, username: $username, email: $email, password: $password)
            }
            else if selectedView == 3 {
                OnboardingInformation()
            }
            
            VStack (spacing: 25){
                Spacer()
                
                HStack {
                    if selectedView == 0 {
                        Capsule()
                            .fill(userManager.textColor)
                            .frame(width: 30, height: 10)
                            .transition(.scale)
                    } else {
                        Circle()
                            .fill(userManager.textColor)
                            .frame(width: 10, height: 10)
                            .transition(.scale)
                    }
                    if selectedView == 1 {
                        Capsule()
                            .fill(userManager.textColor)
                            .frame(width: 30, height: 10)
                            .transition(.scale)
                    } else {
                        Circle()
                            .fill(userManager.textColor)
                            .frame(width: 10, height: 10)
                            .transition(.scale)
                    }
                    if selectedView == 2 {
                        Capsule()
                            .fill(userManager.textColor)
                            .frame(width: 30, height: 10)
                            .transition(.scale)
                    } else {
                        Circle()
                            .fill(userManager.textColor)
                            .frame(width: 10, height: 10)
                            .transition(.scale)
                    }
                    if selectedView == 3 {
                        Capsule()
                            .fill(userManager.textColor)
                            .frame(width: 30, height: 10)
                            .transition(.scale)
                    } else {
                        Circle()
                            .fill(userManager.textColor)
                            .frame(width: 10, height: 10)
                            .transition(.scale)
                    }
                }
                
                if selectedView == 0 || selectedView == 1  {
                    HStack {
                        customButton(text: "<", color: userManager.textColor, width: 50, height: 50, action: {
                            withAnimation(.linear){
                                if selectedView > 0 {
                                    selectedView -= 1
                                }
                            }
                        }, textColor: userManager.textColor)
                        Spacer()
                        customButton(text: ">", color: userManager.textColor, width: 50, height: 50, action: {
                            withAnimation(.linear){
                                if selectedView < 3 {
                                    selectedView += 1
                                }
                            }
                        }, textColor: userManager.textColor)
                    }
                    .padding(.horizontal, 15)
                    .transition(.scale)
                    
                }
                else if selectedView == 2 {
                    HStack {
                        customButton(text: "<", color: userManager.textColor, width: 50, height: 50, action: {
                            withAnimation(.linear){
                                if selectedView > 0 {
                                    selectedView -= 1
                                }
                            }
                        }, textColor: userManager.textColor)
                        Spacer()
                        if !isSigned {
                            Button(action: {
                                withAnimation {
                                    isSigned = true
                                }
                                print("Created")
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    let newUser = UserDataModel(id: UUID(), username: username, name: name, email: email, password: password, netWorth: 0, availableBalance: 0, friends: [], businesses: [], tokens: 0, sessionHistory: [], userLevel: 0, badges: [], inventory: [])
                                    
                                    do {
                                        context.insert(newUser)
                                        print("User created!")
                                        try context.save()
                                    } catch {
                                        print("Couldnt create a User!")
                                    }
                                    
                                }
                            }) {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(userManager.textColor, lineWidth: 2)
                                    .frame(width: 150, height: 50)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 150, height: 50)
                                            .foregroundStyle(getColor(userManager.accentColor))
                                            .opacity(0.1)
                                            .overlay {
                                                Text("Sign Up")
                                                    .font(.title2)
                                                    .foregroundStyle(getColor(userManager.accentColor))
                                            }
                                    }
                            }
                        } else {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 150, height: 50)
                                .foregroundColor(userManager.textColor)
                                .overlay (
                                    HStack {
                                        Image(systemName: "checkmark.seal.fill")
                                            .foregroundColor(userManager.mainColor)
                                        Text("Created")
                                            .foregroundColor(userManager.mainColor)
                                            .font(.title2)
                                    }
                                )
                        }
                        Spacer()
                        customButton(text: ">", color: userManager.textColor, width: 50, height: 50, action: {
                            withAnimation(.linear){
                                if selectedView < 3 && isSigned == true {
                                    selectedView += 1
                                }
                            }
                        }, textColor: userManager.textColor)
                    }
                    .padding(.horizontal, 15)
                }
                else {
                    customButton(text: "Start Earning", color: userManager.textColor, width: 180, height: 50, action: {
                        withAnimation(.linear){
                            userManager.isUserCreated = true
                        }
                    }, textColor: userManager.textColor)
                }
            }
            
            VStack {
                HStack {
                    Image("\(userManager.isDarkMode ? "Hammer" : "HammerBlack")")
                        .resizable()
                        .frame(width: 40, height: 40)
                    Spacer()
                    DayNighCycle(isDay: $userManager.isDarkMode)
                }
                Spacer()
            }
            .frame(width: screenWidth-20, alignment: .trailing)
        }
    }
}

#Preview {
    OnboardingMain()
        .environmentObject(UserManager())
}

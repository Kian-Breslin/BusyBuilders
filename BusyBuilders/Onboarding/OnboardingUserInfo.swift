//
//  OnboardingUserInfo.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 01/01/2026.
//


import SwiftUI

struct OnboardingUserInfo: View {
    @EnvironmentObject var userManager: UserManager
    
    @State var moveHeroSection = false
    
    @Binding var name: String
    @Binding var username: String
    @Binding var email: String
    @Binding var password: String
    
    @State var isSigned = false
    
    var body: some View {
        ZStack {
            userManager.mainColor.ignoresSafeArea()
            
            VStack {
                VStack {
                    Image(systemName: "person")
                        .font(.system(size: 150))
                        .foregroundStyle(getColor(userManager.accentColor).gradient)
                        .padding(.bottom, 15)
                    
                    
                    
                    Text("Tell us about yourself!")
                        .bold()
                        .kerning(1.5)
                        .font(.title3)
                }
                .offset(y: moveHeroSection ? -50 : 0)
                
                VStack (alignment: .leading, spacing: 5){
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Name")
                            .font(.caption)
                            .foregroundColor(.white)

                        TextField("", text: $name, prompt: Text("Name").foregroundColor(.gray).font(.title))
                        .padding(.vertical, 5)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Username")
                            .font(.caption)
                            .foregroundColor(.white)

                        TextField("", text: $username, prompt: Text("Username").foregroundColor(.gray).font(.title))
                        .padding(.vertical, 5)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Email")
                            .font(.caption)
                            .foregroundColor(.white)

                        TextField("", text: $email, prompt: Text("Email").foregroundColor(.gray).font(.title))
                        .padding(.vertical, 5)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Password")
                            .font(.caption)
                            .foregroundColor(.white)

                        TextField("", text: $password, prompt: Text("Password").foregroundColor(.gray).font(.title))
                        .padding(.vertical, 5)
                    }
                }
                .padding(15)
                
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
    OnboardingUserInfo(name: .constant(""), username: .constant(""), email: .constant(""), password: .constant(""))
        .environmentObject(UserManager())
}

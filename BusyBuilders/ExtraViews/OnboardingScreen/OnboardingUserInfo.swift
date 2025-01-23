//
//  OnboardingUserInfo.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 19/11/2024.
//

import SwiftUI
import SwiftData

struct OnboardingUserInfo: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.modelContext) var context
    
    @Binding var currentScreen : Int
    @State var load = false
    
    // Create user
    @State var newUserName = ""
    @State var newUserUsername = ""
    @State var newUserEmail = ""
    @State var newUserPassword = ""
    @State var revealPassword = false
    
    var body: some View {
        ZStack {
            themeManager.mainColor
                .ignoresSafeArea()
            
            VStack (spacing: 15){
                HStack (alignment: .bottom){
                    Text("Create your")
                        .font(.system(size: 25))
                    
                    Text("Account")
                        .font(.system(size: 30))
                        .foregroundStyle(getColor(themeManager.secondaryColor))
                }
                
                Text("Fill out the form below then Click the arrow")
                
                VStack (alignment: .leading, spacing: 25){
                    VStack (alignment: .leading, spacing: 2){
                        Text("Enter your Name")
                            .font(.system(size: 12))
                        
                        TextField("Name", text: $newUserName)
                            .font(.system(size: 25))
                    }
                    VStack (alignment: .leading, spacing: 2){
                        Text("Enter a Username")
                            .font(.system(size: 12))
                        
                        TextField("Username", text: $newUserUsername)
                            .font(.system(size: 25))
                    }
                    VStack (alignment: .leading, spacing: 2){
                        Text("Enter your Email")
                            .font(.system(size: 12))
                        
                        TextField("Email", text: $newUserEmail)
                            .font(.system(size: 25))
                    }
                    VStack (alignment: .leading, spacing: 2){
                        Text("Enter a Password")
                            .font(.system(size: 12))
                        
                        HStack {
                            if revealPassword {
                                TextField("Password", text: $newUserPassword)
                                    .font(.system(size: 25))
                            } else {
                                SecureField("Password", text: $newUserPassword)
                                    .font(.system(size: 25))
                            }
                            
                            Image(systemName: revealPassword ? "eye" : "eye.slash")
                                .onTapGesture {
                                    revealPassword.toggle()
                                }
                        }
                    }
                }
                .frame(width: screenWidth-20, alignment: .leading)
                .padding(.vertical, 60)
                
                Spacer()
                HStack {
                    Spacer()
                    Circle()
                        .frame(width: 70, height: 70)
                        .padding()
                        .overlay {
                            Circle()
                                .trim(from: 0, to: load ? 0.66 : 0.33)
                                .stroke(lineWidth: 5)
                                .rotationEffect(Angle(degrees: -90))
                                .frame(width: 75, height: 75)
                                .foregroundStyle(getColor(themeManager.secondaryColor))
                            Image(systemName: "arrow.right")
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
                    
                    let newUser = UserDataModel(username: newUserUsername, name: newUserName, email: newUserEmail, password: newUserPassword,created: Date())
                    newUser.bankAccount = BankAccountModel(owner: newUser, accountNumber: createBankAccountNumber(), balance: 0, savingsBalance: 0)
                    context.insert(newUser)
                    
                    do {
                        try context.save()
                        currentScreen += 1
                        print("Successfully Made User")
                    } catch {
                        print("User could not be created")
                    }
                }
            }
        }
        .foregroundStyle(themeManager.textColor)
    }
}

#Preview {
    OnboardingUserInfo(currentScreen: .constant(0))
        .environmentObject(ThemeManager())
}

//
//  UserSignUp.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 05/10/2024.
//

import SwiftUI
import SwiftData

struct UserSignUp: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @Environment(\.modelContext) var context
    @Query var users: [UserDataModel]
    @EnvironmentObject var userManager: UserManager
    
    @State var username = ""
    @State var name = ""
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 244/255, green: 73/255, blue: 73/255), Color(red: 245/255, green: 245/255, blue: 220/255)]),startPoint: .center,endPoint: .bottom)
            .ignoresSafeArea()
            
            VStack {
                Text("BusyBuilders")
                    .font(.system(size: 40))
                Spacer()
                VStack {
                    Text("Enter your name below!")
                        .frame(width: screenWidth-20, alignment: .leading)
                    TextField("Name", text: $name)
                        .cornerRadius(8)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 15)
                    
                    Text("Enter a username")
                        .frame(width: screenWidth-20, alignment: .leading)
                    TextField("Username", text: $name)
                        .cornerRadius(8)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 15)
                    
                    Text("Enter your email below!")
                        .frame(width: screenWidth-20, alignment: .leading)
                    TextField("Email", text: $email)
                        .cornerRadius(8)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 15)
                    
                    Text("Enter your password below!")
                        .frame(width: screenWidth-20, alignment: .leading)
                    SecureField("Password", text: $password)
                        .cornerRadius(8)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 15)
                }
                
                Spacer()
                
                Button("Get Started!"){
                    let newUser = UserDataModel(username: username, name: name, email: email, password: password)
                    
                    context.insert(newUser)
                    do {
                        try context.save()
                        print("Successfully Made User")
                        userManager.isUserCreated = true
                    } catch {
                        print("Failed to save user: \(error.localizedDescription)")
                    }
                }
                .frame(width: 300, height: 50)
                .background(Color(red: 244/255, green: 73/255, blue: 73/255))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundStyle(.white)
                .fontWeight(.bold)
            }
        }
    }
}

#Preview {
    UserSignUp()
        .modelContainer(for: [UserDataModel.self])
        .environmentObject(ThemeManager())
        .environmentObject(UserManager())
}

//
//  SettingsNavigation.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 22/10/2024.
//

import SwiftUI
import SwiftData

struct SettingsNavigation: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var userManager: UserManager
    
    @Query var users: [UserDataModel]
    @Environment(\.modelContext) var context
    
    @State var textForView : String
    @State var selectedBusinessIndex : Int = 1
    @State var selectedBusiness : BusinessDataModel?
    
    @State var updatedUserName = ""
    @State var updatedUserUsername = ""
    @State var updatedUserEmail = ""
    
    let cash = [1000, 10000, 50000, 100000]
    
    var body: some View {
        if textForView == "Profile Settings" {
            ZStack {
                getColor("black")
                    .ignoresSafeArea()
                
                VStack {
                    
                    VStack (spacing: 15){
                        VStack (alignment: .leading, spacing: 2){
                            Text("New User Name")
                                .foregroundStyle(getColor("white"))
                                .font(.system(size: 12))
                            TextField("\(updatedUserName)", text: $updatedUserName)
                                .textFieldStyle(.roundedBorder)
                        }
                        .padding(.horizontal)
                        
                        VStack (alignment: .leading, spacing: 2){
                            Text("New User Username")
                                .foregroundStyle(getColor("white"))
                                .font(.system(size: 12))
                            TextField("\(updatedUserUsername)", text: $updatedUserUsername)
                                .textFieldStyle(.roundedBorder)
                        }
                        .padding(.horizontal)
                        
                        VStack (alignment: .leading, spacing: 2){
                            Text("New User Email")
                                .foregroundStyle(getColor("white"))
                                .font(.system(size: 12))
                            TextField("\(updatedUserEmail)", text: $updatedUserEmail)
                                .textFieldStyle(.roundedBorder)
                        }
                        .padding(.horizontal)
                        
                        Button("Update User") {
                            
                            users.first?.username = updatedUserUsername
                            users.first?.name = updatedUserName
                            users.first?.email = updatedUserEmail
                            
                            do {
                                try context.save()
                            } catch {
                                print("Couldnt save new user")
                            }
                            updatedUserUsername = ""
                            updatedUserName = ""
                            updatedUserEmail = ""
                        }
                        .frame(width: 200, height: 40)
                        .background(getColor("red"))
                        .foregroundStyle(getColor("white"))
                    }
                    
                    ScrollView (.horizontal){
                        HStack {
                            ForEach(users){ u in
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: 100, height: 100)
                                    .overlay {
                                        Text("\(u.username)")
                                            .foregroundStyle(getColor("black"))
                                    }
                            }
                        }
                        .padding()
                    }
                    
                    
                    
                    Button("Add Quick User"){
                        let newUser = UserDataModel(username: "LilKim", name: "Kim", email: "KimberlyLeon01@gmail.com")
                        
                        context.insert(newUser)
                        
                        do {
                            try context.save()
                        } catch {
                            print("Couldnt save new user")
                        }
                    }
                    .frame(width: 200, height: 40)
                    .background(getColor("red"))
                    .foregroundStyle(getColor("white"))
                    
                    Button("Remove All Users"){
                        for user in users {
                                context.delete(user)
                            }
                        
                        do {
                            try context.save()
                            userManager.isUserCreated = false
                        } catch {
                            print("Couldnt delete users")
                        }
                    }
                    .frame(width: 200, height: 40)
                    .background(getColor("blue"))
                    .foregroundStyle(getColor("white"))
                }
            }
        }
        else if textForView == "About" {
            AdminTests()
        }
        else {
            Text(textForView)
        }

    }
}

#Preview {
    SettingsNavigation(textForView: "Profile Settings")
        .modelContainer(for: UserDataModel.self, inMemory: true)
        .environmentObject(ThemeManager())
}

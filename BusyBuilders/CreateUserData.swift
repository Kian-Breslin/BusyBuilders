//
//  CreateUserData.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 28/05/2024.
//

import SwiftUI
import SwiftData

struct CreateUserData: View {
    
    @Environment(\.modelContext) private var context
    
    @State private var username : String = ""
    
    var body: some View {
        VStack {
            Form {
                TextField("Username", text: $username)
            }
            .frame(width: .infinity, height: 100)
            
            Button("Add User") {
                addItem()
            }
            .frame(width: 100, height: 40)
            .background(.black)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
    
    func addItem() {
        // Create the User
        
        let newUser = UserDataModel(username: username, userProfile: "store", currentNumberOfBusinesses: 0, totalRevenue: 0)
        
        // Add user to data Context
        context.insert(newUser)
    }
}

#Preview {
    CreateUserData()
}

//
//  Profile.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 29/05/2024.
//

import SwiftUI
import SwiftData

struct Profile: View {
    
    @Query var user : [UserDataModel]
    
    var usernameTest : String
    
    var body: some View {
        
        if(user.isEmpty) {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                    .opacity(0.2)
                
                VStack {
                    HStack {
                        Image(systemName: "circle")
                            .font(.system(size: 60))
                        Text(usernameTest)
                            .font(.system(size: 40))
                            .bold()
                    }
                    .padding()
                    
                    
                }
                
            }
        } else {
            Text("\(user[0].username)")
        }
        
    }
}

#Preview {
    Profile(usernameTest: "Kian Breslin")
        .modelContainer(for: [BusinessDataModel.self, UserDataModel.self], inMemory: true)
}

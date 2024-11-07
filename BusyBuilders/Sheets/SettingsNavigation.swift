//
//  SettingsNavigation.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 22/10/2024.
//

import SwiftUI
import SwiftData

struct SettingsNavigation: View {
    
    @Query var users: [UserDataModel]
    
    @State var textForView : String
    
    var body: some View {
        if textForView == "Profile Settings" {
            Button("Click Here to change Username"){
                users.first?.username = "Kian Aaron Breslin"
            }
        }
        else if textForView == "About" {
            VStack {
                Text("Admin Work")
                    .font(.system(size: 30))
                    .frame(width: screenWidth-30, alignment: .trailing)
                Spacer()
                
                VStack {
                    
                }
            }
        }
        else {
            Text(textForView)
        }

    }
}

#Preview {
    SettingsNavigation(textForView: "About")
}

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
    @State var selectedBusinessIndex : Int = 1
    @State var selectedBusiness : BusinessDataModel?
    
    let cash = [1000, 10000, 50000, 100000]
    
    var body: some View {
        if textForView == "Profile Settings" {
            Button("Click Here to change Username"){
                users.first?.username = "Kian Aaron Breslin"
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
    SettingsNavigation(textForView: "About")
        .modelContainer(for: UserDataModel.self, inMemory: true)
}

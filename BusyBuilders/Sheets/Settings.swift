//
//  Settings.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 05/10/2024.
//

import SwiftUI

struct Settings: View {
    @Binding var userColorPreference: String
    
    var body: some View {
        VStack {
            Text("Choose a color preference:")
            Button("Set to Red") {
                userColorPreference = "red"
            }
            Button("Set to Blue") {
                userColorPreference = "blue"
            }
            Button("Set to Green") {
                userColorPreference = "green"
            }
        }
    }
}

#Preview {
    Settings(userColorPreference: .constant("red"))
}

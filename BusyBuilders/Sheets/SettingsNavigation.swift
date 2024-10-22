//
//  SettingsNavigation.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 22/10/2024.
//

import SwiftUI

struct SettingsNavigation: View {
    
    @State var textForView : String
    
    var body: some View {
        Text(textForView)
    }
}

#Preview {
    SettingsNavigation(textForView: "Hellllooooo")
}

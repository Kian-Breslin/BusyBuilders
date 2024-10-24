//
//  Communities.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 23/09/2024.
//

import SwiftUI

struct Communities: View {
    
    @AppStorage("userColorPreference") var userColorPreference: String = "red"
    
    var body: some View {
        ZStack {
            getColor(userColorPreference)
                .ignoresSafeArea()
            
            VStack {
                Text("Coming Soon")
            }
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    Communities()
        .modelContainer(for: UserDataModel.self)
}

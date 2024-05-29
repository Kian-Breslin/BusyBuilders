//
//  Settings.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 28/05/2024.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
                .opacity(0.2)
            
            Text("Settings")
                .font(.system(size: 50))
                .foregroundStyle(.red)
                
        }
    }
}

#Preview {
    Settings()
}

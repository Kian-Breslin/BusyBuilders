//
//  Settings.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 28/09/2024.
//

import SwiftUI

struct Settings: View {
    
    @State var UserDarkMode = true
    
    @State private var selectedColor = "Blue"
    let colors = ["Blue", "Red", "Green", "Purple", "White", "Black"]
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack (alignment: .leading){
                HStack {
                    Text("Color Scheme")
                    Spacer()
                    Circle()
                        .frame(width: 30)
                        .foregroundStyle(colorForName(selectedColor))
                        
                    Spacer()
                    Picker("Select a Color", selection: $selectedColor) {
                        ForEach(colors, id: \.self) { color in
                            Text(color)
                        }
                    }
                }
                Divider()
                
                HStack {
                    Toggle("Mode", isOn: $UserDarkMode)
                }
                    
            }
            .padding(.horizontal)
            .font(.system(size: 20))
        }
        .foregroundStyle(.black)
    }
}

#Preview {
    Settings()
}

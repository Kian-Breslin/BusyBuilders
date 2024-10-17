//
//  Chats.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 23/09/2024.
//

import SwiftUI

struct Messages: View {
    
    @State var grow = true
    
    let ColorsArray: [Color] = [
        Color(red: 173/255, green: 216/255, blue: 230/255), // Light Blue
        Color(red: 135/255, green: 206/255, blue: 235/255), // Sky Blue
        Color(red: 70/255, green: 130/255, blue: 180/255),  // Steel Blue
        Color(red: 0/255, green: 191/255, blue: 255/255),   // Deep Sky Blue
        Color(red: 30/255, green: 144/255, blue: 255/255),  // Dodger Blue
        Color(red: 65/255, green: 105/255, blue: 225/255),  // Royal Blue
        Color(red: 0/255, green: 0/255, blue: 255/255),     // Pure Blue
        Color(red: 0/255, green: 0/255, blue: 139/255),     // Dark Blue
        Color(red: 25/255, green: 25/255, blue: 112/255),   // Midnight Blue
        Color(red: 0/255, green: 0/255, blue: 205/255),     // Medium Blue
        Color(red: 240/255, green: 248/255, blue: 255/255)  // Alice Blue
    ]
    
    let colorNamesArray: [String] = [
        "Light Blue",      // #ADD8E6
        "Sky Blue",        // #87CEEB
        "Steel Blue",      // #4682B4
        "Deep Sky Blue",   // #00BFFF
        "Dodger Blue",     // #1E90FF
        "Royal Blue",      // #4169E1
        "Pure Blue",       // #0000FF
        "Dark Blue",       // #00008B
        "Midnight Blue",   // #191970
        "Medium Blue",     // #0000CD
        "Alice Blue"       // #F0F8FF
    ]

    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            HStack {
                ScrollView (.horizontal) {
                    HStack {
                        ForEach(ColorsArray.indices, id: \.self) { c in
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 100, height: 100)
                                .foregroundStyle(ColorsArray[c])
                                .overlay {
                                    Text("\(colorNamesArray[c])")
                                        .foregroundStyle(.white)
                                }
                        }
                        .padding()
                    }
                }
            }
        }
        .animation(.easeInOut(duration: 0.5), value: grow)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    Messages()
}

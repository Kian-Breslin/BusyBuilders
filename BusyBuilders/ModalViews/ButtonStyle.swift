//
//  ButtonStyle.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 12/05/2025.
//

import SwiftUI

struct ButtonStyle: View {
    var text : String
    var action : () -> Void
    var sizex : Double
    var sizey : Double
    var color : Color
    
    var body: some View {
        Button("\(text)"){
            action()
        }
        .frame(width: sizex, height: sizey)
        .foregroundStyle(.white)
        .background(color)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    ButtonStyle(text: "Placeholder", action: {print("Hello World!")}, sizex: 100, sizey: 50, color: .red)
}

//
//  Button.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 21/07/2025.
//

import SwiftUI
import SwiftData

struct customButton: View {
    @EnvironmentObject var userManager: UserManager
    var text: String
    var color: Color
    var width: CGFloat
    var height: CGFloat
    var action: () -> Void
    var textColor: Color? = UserManager().textColor

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(color, lineWidth: 2)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(color.opacity(0.3))
            )
            .frame(width: width, height: height)
            .overlay(
                Text(text)
                    .foregroundColor(textColor)
                    .bold()
                    .multilineTextAlignment(.center)
            )
            .onTapGesture {
                action()
            }
    }
}

struct customImageButton: View {
    @EnvironmentObject var userManager: UserManager
    var image: String
    var color: Color
    var width: CGFloat
    var height: CGFloat
    var action: () -> Void
    var textColor: Color? = UserManager().textColor

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(color, lineWidth: 2)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(color.opacity(0.3))
            )
            .frame(width: width, height: height)
            .overlay(
                Image(systemName: image)
                    .foregroundColor(textColor)
                    .font(.largeTitle)
            )
            .onTapGesture {
                action()
            }
    }
}

#Preview {
    customImageButton(image: "cursorarrow", color: .red, width: 50, height: 50, action: {})
        .environmentObject(UserManager())
}

#Preview {
    customButton(text: "Tap Me", color: .blue, width: 100, height: 50) {
        print("Button tapped")
    }
    .environmentObject(UserManager())
}

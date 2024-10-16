//
//  FlashCards.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 10/10/2024.
//

import SwiftUI
import SwiftData

struct FlashCard: View {
    
    @AppStorage("userColorPreference") var userColorPreference: String = "red"
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @Query var users: [UserDataModel]
    @Query var businesses: [BusinessDataModel] // Query for businesses
    
    @State var circleSize: CGFloat = 40 // Unified size for the circle
    @State var isBeingPressed = false
    @State var question : String
    @State var answer : String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: screenWidth - 30, height: 200)
                .foregroundStyle(.black)
                .overlay {
                    Circle() // Use Circle for proper shape
                        .frame(width: circleSize, height: circleSize) // Use the unified size
                        .foregroundStyle(.white)
                        .offset(x: 150, y: 70)
                        .onLongPressGesture(minimumDuration: 0.1, pressing: { isPressing in
                            if isPressing {
                                // When pressing, enlarge the circle
                                print("Circle is being pressed")
                                circleSize = 800 // Enlarge to 500
                                isBeingPressed.toggle()
                            } else {
                                // When released, shrink the circle
                                print("Circle was released")
                                circleSize = 40 // Reset to original size
                                isBeingPressed.toggle()
                            }
                        }, perform: {
                            // Optional action after long press
                        })
                }
            Text(question)
                .foregroundStyle(.white)
                .opacity(isBeingPressed ? 0 : 1)
                .frame(width: screenWidth-80, height: 150, alignment: .topLeading)
                .font(.system(size: 30))
            
            Text(answer)
                .foregroundStyle(.black)
                .font(.system(size: 30))
                .opacity(isBeingPressed ? 1 : 0)
                .frame(width: screenWidth-80, height: 150, alignment: .bottomLeading)
        }
        .clipped()
        .animation(.linear(duration: 0.2), value: circleSize)
    }
}

#Preview {
    FlashCard(question: "What is the capital of Ireland", answer: "Dublin")
}

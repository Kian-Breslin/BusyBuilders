//
//  CVSwiper.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 18/07/2025.
//

import SwiftUI
import SwiftData

enum SwipeDirection {
    case left, right
}

struct CVSwiper: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userManager: UserManager
    @State var cardArray : [cardDetails] = [
        cardDetails(text: "Card 1", color: "red"),
        cardDetails(text: "Card 2", color: "orange"),
        cardDetails(text: "Card 3", color: "blue"),
        cardDetails(text: "Card 4", color: "green"),
        cardDetails(text: "Card 5", color: "yellow"),
        cardDetails(text: "Card 6", color: "blue")
    ]
    @State var removeCard = false
    
    @State var cardArrayLeft : [cardDetails] = []
    @State var cardArrayRight : [cardDetails] = []
    

    var body: some View {
        ZStack {
            userManager.mainColor.ignoresSafeArea()
            
            if cardArray.isEmpty {
                VStack {
                    Text("Completed")
                    HStack {
                        VStack {
                            ForEach(cardArrayLeft, id: \.self) { card in
                                Text("\(card.text)")
                            }
                        }
                        
                        VStack {
                            ForEach(cardArrayRight, id: \.self) { card in
                                Text("\(card.text)")
                            }
                        }
                    }
                }
                .foregroundStyle(userManager.textColor)
            } else {
                ForEach(cardArray, id: \.self) { card in
                    cardView(text: card.text, color: card.color) { direction in
                        print("Removed \(card.text) by swiping \(direction == .left ? "left" : "right")")
                        if direction == .right {
                            cardArrayRight.append(card)
                        }
                        if direction == .left {
                            cardArrayLeft.append(card)
                        }
                        cardArray.removeAll(where: { $0.text == card.text })
                    }
                }
            }

        }
    }
}

struct cardDetails : Hashable{
    let text: String
    let color: String
}

struct cardView: View {
    @State var xOffsetValue : CGFloat = 0
    @State var degrees: Double = 0

    let text: String
    let color: String
    let onRemove: (SwipeDirection) -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 350, height: 500)
            Text(text)
                .foregroundStyle(.white)
                
        }
        .offset(x: xOffsetValue)
        .rotationEffect(.degrees(degrees))
        .foregroundStyle(getColor(color))
        .animation(.snappy, value: xOffsetValue)
        .gesture(
            DragGesture()
                .onChanged { value in
                    xOffsetValue = value.translation.width
                    degrees = Double(value.translation.width/25)
                
                }
                .onEnded({ value in
                    let width = value.translation.width
                    
                    if abs(width) < 150 {
                        degrees = 0
                        xOffsetValue = 0
                    } else if width < 0 {
                        print("Swiped Left")
                        onRemove(.left)
                    } else {
                        print("Swiped Right")
                        onRemove(.right)
                    }
                })
        )
    }
}

#Preview {
    CVSwiper()
        .environmentObject(UserManager())
}

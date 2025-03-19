//
//  Light.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 05/03/2025.
//

import SwiftUI

struct Light: View {
    @State private var value: CGFloat = 0.0
    @State private var dragAmount: CGFloat = 0.0 // Track drag distance
    @State var lightOn: Bool = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            IrregularRectangle()
                .fill(Color.yellow.opacity(lightOn ? 0.5 : 0))
                .frame(width: screenWidth-20, height: 500)
                .blur(radius: 50)
                .position(x: screenWidth/2, y: 240)
                
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 2, height: 100)
                .foregroundStyle(.white)
                .position(x: (screenWidth/2) + 150, y: -15)
            
            Group {
                // Lamp body (Rounded rectangle)
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 2, height: 120)
                    .foregroundStyle(.white)
                    .offset(y: dragAmount)
                    
                
                Circle()
                    .frame(width: 20)
                    .foregroundStyle(.yellow)
                    .offset(y: 60 + dragAmount) // Move the circle based on drag
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newDragAmount = value.translation.height
                                if newDragAmount >= 0 && newDragAmount <= 80 {
                                    self.dragAmount = newDragAmount
                                }
                            }
                            .onEnded { _ in
                                withAnimation(.bouncy(duration: 1, extraBounce: 0.3)) {
                                    dragAmount = 0.0
                                    if lightOn {
                                        lightOn = false
                                    } else {
                                        lightOn = true
                                    }
                                }
                            }
                    )
            }
            .position(x: (screenWidth/2) + 150, y: 15)
            Text("Hello World!")
                .foregroundStyle(.black)
                .font(.system(size: 50))
        }
    }
}

#Preview {
    Light()
}

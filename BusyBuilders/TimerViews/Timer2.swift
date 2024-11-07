//
//  Timer2.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 03/11/2024.
//

import SwiftUI

struct Timer2: View {
    
    @AppStorage("userColorPreference") var userColorPreference: String = "red"
    @Environment(\.verticalSizeClass) var heightSizeClass : UserInterfaceSizeClass?
    
    @State var moveMinuteHand = 0
    @State var moveHourHand = 0
    @State var minutesCounter = 1
    @State var hourCounter = 1
    @State var seconds = 0
    
    
    var body: some View {
        ZStack {
            
            getColor("white")
                .ignoresSafeArea()
            Circle()
                .frame(width: 300, height: 300)
                .foregroundStyle(getColor("black"))
            
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .frame(width: 25, height: 100)
                .offset(y: -40) // Adjust length and placement
                .rotationEffect(.degrees(Double((moveHourHand/60)*6)))
                .animation(.linear(duration: 1), value: hourCounter)
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray)
                .frame(width: 5, height: 130)
                .offset(y: -65) // Adjust length and placement
                .rotationEffect(.degrees(Double((moveMinuteHand/60)*6)))
            
            Circle()
                .frame(width: 20, height: 20)
                .foregroundStyle(.red)
                .offset(x: 0, y: -130) // Position at the top of the circle's path
                .rotationEffect(.degrees(Double(seconds * 6))) // 6 degrees per second (360 / 60)
                .animation(.linear(duration: 0.1), value: seconds) // Smooth rotation

        }
        .onTapGesture {
            moveMinuteHand += 900
            seconds += 1
            if moveMinuteHand == 3600 {
                moveHourHand += 60
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                seconds += 1
                
                if seconds == minutesCounter * 60 {
                    moveMinuteHand += 60
                    minutesCounter += 1
                }
                if moveMinuteHand == hourCounter * 3600 {
                    moveHourHand += 60
                    hourCounter += 1
                }
            }
        }
    }
}

#Preview {
    Timer2()
}

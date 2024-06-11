//
//  TimerView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 29/05/2024.
//

import SwiftUI

struct TimerView: View {
    
    
    @Binding var timeRemaining : Int
    @Binding var isActive : Bool
    // Test for Preview
    @State var previewIsActive = true
    @State var previewTimeRemaining = 3600
    
    
    @Binding var timeElapsed : Int
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenePhase

    
    var body: some View {
        VStack {
            Text("Time Remaining")
                .foregroundStyle(.black)
                .opacity(0.4)
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 370, height: 80)
                .foregroundStyle(Color(red: 36/255, green: 36/255, blue: 36/255))
                .overlay {
                    Text("\(timeFormatted(timeRemaining))")
                        .font(.system(size: 40))
                        .foregroundStyle(.white)
                }
        }
        .onReceive(timer) { time in
            guard isActive else {return}
            
            if timeRemaining > 0 {
                timeRemaining -= 1
                timeElapsed += 1
            }
        }
        .onChange(of: scenePhase){
            if scenePhase == .active {
                isActive = true
            } else {
                isActive = false
            }
        }
    }
}

#Preview {
    TimerView(timeRemaining: .constant(3600), isActive: .constant(true), timeElapsed: .constant(0))
}

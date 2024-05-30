//
//  TimerView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 29/05/2024.
//

import SwiftUI

struct TimerView: View {
    
    // 30 mins = 60*30
    // 1 hour = 60*60
    // 1.5 hours = 60*90
    // 2 hours = 60*120
    @Binding var chosenTime: String
    @State var timeRemaining: Int = 3600
    @State var timerIsRunning: Bool = false
    @State var timer: Timer?
    
    @Environment(\.scenePhase) var schenePhase
    @State var isActive = true
    
    var body: some View {
        VStack(spacing: 5) {
            Text("\(timeFormatted(timeRemaining))")
                .font(.largeTitle)
                .padding()

            HStack(spacing: 10) {
                Button(action: {
                    if timerIsRunning {
                        pauseTimer()
                    } else {
                        startTimer()
                    }
                }) {
                    Text(timerIsRunning ? "Pause" : "Start")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Button(action: resetTimer) {
                    Text("Reset")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .frame(width: 200, height: 150)
        .background(.gray)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding()
    }

    func startTimer() {
        timerIsRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                pauseTimer()
            }
        }
    }

    func pauseTimer() {
        timerIsRunning = false
        timer?.invalidate()
    }

    func resetTimer() {
        pauseTimer()
        timeRemaining = 60
    }

    func timeFormatted(_ totalSeconds: Int) -> String {
        let hours = totalSeconds / 3600
        
        let minutes = (totalSeconds % 3600)/60

        let seconds = totalSeconds % 60
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

#Preview {
    TimerView(chosenTime: .constant("1 hour"))
}

//
//  ActiveTaskView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 29/05/2024.
//

import SwiftUI
import SwiftData

struct ActiveTaskView: View {

    @State var timeRemaining : Int
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenePhase
    @State var isActive = true
    
    var body: some View {
        ZStack {
            Color.red
                .ignoresSafeArea()
            Text("Time Remaining: \(timeFormatted(timeRemaining))")
                .font(.system(size: 40))
        }
        .onReceive(timer) { time in
            guard isActive else {return}
            
            if timeRemaining > 0 {
                timeRemaining -= 1
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
    func timeFormatted(_ totalSeconds: Int) -> String {
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}


#Preview {
    ActiveTaskView(timeRemaining: 3600)
        .modelContainer(for: [BusinessDataModel.self], inMemory: true)
}

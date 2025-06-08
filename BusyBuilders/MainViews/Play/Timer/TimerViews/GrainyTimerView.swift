//
//  GrainyTimerView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 26/04/2025.
//

import SwiftUI

struct GrainyTimerView: View {
    @StateObject private var timerManager = TimerManager()
    
    var body: some View {
        ZStack {
            Image("GrainTextureBB")
                .resizable()
                .opacity(0.6)
                .frame(width: screenWidth, height: screenHeight)
                .ignoresSafeArea()
            
            VStack {
                Text("Time: \(timerManager.timeElapsed)")
    //                .onAppear {
    //                    timerManager.start()
    //                }
                
            }
        }
    }
}

#Preview {
    GrainyTimerView()
}

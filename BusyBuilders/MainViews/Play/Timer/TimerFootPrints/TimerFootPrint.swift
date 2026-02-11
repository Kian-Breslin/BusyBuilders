//
//  TimerFootPrint.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 30/11/2025.
//

import SwiftUI
import SwiftData

struct TimerFootPrint: View {
    @EnvironmentObject var userManager : UserManager
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.dismiss) var dismiss
    @Query var users : [UserDataModel]
    
    @StateObject var timerManager = TimerManager()
    
    @State var moveRec = -60
    
    @State var fadeFeet = false
    
    var body: some View {
        ZStack {
            Image("SnowFoot")
                .resizable()
                .frame(width: 300, height: 400)
                .rotationEffect(Angle(degrees: -35))
                .opacity(fadeFeet ? 0: 1)
                .animation(.easeOut(duration: 1), value: fadeFeet)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
                        fadeFeet.toggle()
                    }
                }
            
            Rectangle()
                .frame(width: 170, height: 500)
                .foregroundStyle(.white)
                .offset(x: -10, y: CGFloat(moveRec))
                .animation(.linear(duration: 2), value: moveRec)
                .onTapGesture {
                    withAnimation {
                        moveRec = -500
                    }
                }
        }
        .onAppear {
//            timerManager.start()
        }
    }
}

#Preview {
    TimerFootPrint()
        .environmentObject(UserManager())
}

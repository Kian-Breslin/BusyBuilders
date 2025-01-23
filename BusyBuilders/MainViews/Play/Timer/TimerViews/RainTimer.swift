//
//  RainTimer.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 10/01/2025.
//

import SwiftUI

struct RainTimer: View {
    @EnvironmentObject var themeManager : ThemeManager
    
    // Falling Rain
    @State var raining: Bool = false
    @State var rainPosition = -10
    @State var rainHitFloor = false
    @State var rainPositions = [-10, -10, -10, -10, -10]

    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack {
            themeManager.mainColor.ignoresSafeArea()
            
            Rectangle()
                .frame(width: 70, height: 5)
            
            VStack {
                HStack (spacing: 15){
                    ForEach(0..<5){ i in
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 5, height: 15)
                            .foregroundStyle(.teal)
                            .offset(y: CGFloat(rainPosition))
                            .opacity(rainPosition == 355 ? 0 : 1)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                    self.rainPosition += 50*i
                                }
                            }
                    }
                    
                    
                }
                Spacer()
                HStack {
                    Button("Rain") {
                        raining.toggle()
                        rainPosition = 355
                    }
                    Button("Reset") {
                        raining.toggle()
                        rainPosition = -10
                    }
                }
            }
            .foregroundStyle(themeManager.textColor)
            .animation(.easeOut(duration: 1.5), value: raining)
            .animation(.linear(duration: 1), value: rainPosition)
        }
//        .onReceive(timer) { time in
//            if rainPosition <= 300 {
//                rainPosition += 150
//            } else {
//                rainPosition = 0
//            }
//        }
    }
}

#Preview {
    RainTimer()
        .environmentObject(ThemeManager())
}

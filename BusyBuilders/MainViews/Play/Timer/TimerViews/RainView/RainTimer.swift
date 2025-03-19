//
//  RainTimer.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 10/01/2025.
//

import SwiftUI

struct RainTimer: View {
    @EnvironmentObject var themeManager : ThemeManager
    @State private var raindrops: [Raindrop] = (0..<50).map { _ in
            Raindrop(
                x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                speed: CGFloat.random(in: 4...10)
            )
        }

    var body: some View {
        ZStack {
            themeManager.mainColor.ignoresSafeArea()
            
            ForEach(raindrops.indices, id: \.self) { i in
                            if raindrops[i].isSplashing {
                                // Splash effect at the bottom
                                Circle()
                                    .frame(width: 10, height: 5)
                                    .position(x: raindrops[i].x, y: UIScreen.main.bounds.height - 100)
                                    .foregroundColor(.white.opacity(0.7))
                                    .opacity(0.5)
                                    .animation(.easeOut(duration: 0.2), value: raindrops[i].isSplashing)
                            } else {
                                // Falling raindrop
                                RoundedRectangle(cornerRadius: 2)
                                    .frame(width: 2, height: 10)
                                    .position(x: raindrops[i].x, y: raindrops[i].y)
                                    .foregroundColor(.white.opacity(0.7))
                                    .animation(.linear(duration: 0.1), value: raindrops[i].y)
                            }
                        }
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
                    updateRain()
                }
            }
        }
    }
    private func updateRain() {
            for i in raindrops.indices {
                if !raindrops[i].isSplashing {
                    raindrops[i].y += raindrops[i].speed
                    
                    // If raindrop reaches the bottom
                    if raindrops[i].y > UIScreen.main.bounds.height - 100 {
                        raindrops[i].isSplashing = true
                        
                        // Reset raindrop after splash effect
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            raindrops[i] = Raindrop(
                                x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                                speed: CGFloat.random(in: 4...10)
                            )
                        }
                    }
                }
            }
        }
}

struct Raindrop {
    var id = UUID()
    var x : CGFloat
    var y : CGFloat = -100
    var speed : CGFloat
    var isSplashing: Bool = false
}

#Preview {
    RainTimer()
        .environmentObject(ThemeManager())
}

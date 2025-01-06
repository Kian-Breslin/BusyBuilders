//
//  ScratchCards.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 09/12/2024.
//

import SwiftUI

struct ScratchCards: View {
    @State private var maskPath = Path()
    @State private var isFullyScratched = false

    var body: some View {
        ZStack {
            // Background Layer (Prize)
            Text("🎉 You Won! 🎉")
                .font(.largeTitle)
                .foregroundColor(.green)

            // Scratchable Layer
            ScratchableView(maskPath: $maskPath, isFullyScratched: $isFullyScratched)
                .opacity(isFullyScratched ? 0.0 : 1.0)
        }
        .frame(width: 300, height: 200)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 10)
        .padding()
    }
}

struct ScratchableView: View {
    @Binding var maskPath: Path
    @Binding var isFullyScratched: Bool

    var body: some View {
        GeometryReader { geometry in
            Canvas { context, size in
                // Clip the context using the mask path
                context.addFilter(.alphaThreshold(min: 0.01, color: .black))
                context.addFilter(.blur(radius: 5))
                context.clip(to: maskPath)

                // Scratchable Layer Appearance
                context.fill(
                    Rectangle().path(in: CGRect(origin: .zero, size: size)),
                    with: .color(Color.green)
                )
            }
            .gesture(DragGesture()
                .onChanged { value in
                    let point = value.location
                    maskPath.addEllipse(in: CGRect(x: point.x - 10, y: point.y - 10, width: 20, height: 20))

                    // Check if enough area is scratched
                    if calculateScratchedArea(size: geometry.size) > 0.9 {
                        isFullyScratched = true
                    }
                })
        }
    }

    private func calculateScratchedArea(size: CGSize) -> CGFloat {
        // Approximation of the scratched area (for simplicity)
        let scratchedRect = maskPath.boundingRect
        let totalArea = size.width * size.height
        let scratchedArea = scratchedRect.width * scratchedRect.height
        return scratchedArea / totalArea
    }
}

struct ScratchCards_Previews: PreviewProvider {
    static var previews: some View {
        ScratchCards()
    }
}

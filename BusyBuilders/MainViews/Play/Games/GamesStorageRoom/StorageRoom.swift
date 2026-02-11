//
//  StorageRoom.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 25/01/2026.
//

import SwiftUI

struct StorageRoom: View {
    @EnvironmentObject var userManager: UserManager
    @Environment(\.dismiss) var dismiss

    // MARK: - Grid Config
    let rows = 8
    let cols = 8
    let cellSize: CGFloat = 40

    // MARK: - Grid State
    @State private var grid: [[Bool]] =
        Array(repeating: Array(repeating: false, count: 6), count: 6)

    // MARK: - Drag State
    @State private var dragOffset: CGSize = .zero
    @State private var isDragging = false

    var body: some View {
        ZStack {
            userManager.mainColor.ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Storage Room")
                    .font(.largeTitle)
                    .bold()
                
                

                // Grid
                VStack(spacing: 2) {
                    ForEach(0..<rows, id: \.self) { r in
                        HStack(spacing: 2) {
                            ForEach(0..<cols, id: \.self) { c in
                                Rectangle()
                                    .fill(.blue)
                                    .frame(width: 40, height: 40)
                                    .overlay{
                                        GeometryReader { geo in
                                            Color.clear
                                                .contentShape(Rectangle())   // 👈 THIS
                                                .onTapGesture {
                                                    let frame = geo.frame(in: .global)
                                                    print("Tapped at x:", frame.midX, "y:", frame.midY)
                                                }
                                            Text("\(geo.frame(in: .global).midX, specifier: "%.2f"), \(geo.frame(in: .global).midY, specifier: "%.2f")")
                                                .font(.system(size: 10))
                                        }
                                    }
                            }
                        }
                    }
                }

                Spacer()
            }
            .foregroundStyle(userManager.textColor)
            
            Rectangle()
                .fill(.red)
                .frame(width: 40, height: 40)
                .position(x: 96, y: 132.67)
            
            Rectangle()
                .fill(.red)
                .frame(width: 40, height: 40)
                .position(x: 222, y: 300.67)
        }
    }
}

#Preview {
    StorageRoom()
        .environmentObject(UserManager())
}

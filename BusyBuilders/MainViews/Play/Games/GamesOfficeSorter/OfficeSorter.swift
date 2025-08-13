//
//  OfficeSorter.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 08/08/2025.
//

import SwiftUI
import SwiftData

struct OfficeSorter: View {
    @EnvironmentObject var userManager: UserManager
    @State var colors : [Color] = [.teal, .blue, .purple, .green, .yellow]
    @State var gridColors: [Color?] = Array(repeating: nil, count: 25)
    var body: some View {
        ZStack {
            userManager.mainColor.ignoresSafeArea()
            
            let columns = Array(repeating: GridItem(.flexible(), spacing: 1), count: 5)
            VStack {
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(0..<25, id: \.self) { index in
                        Rectangle()
                            .fill(gridColors[index] ?? .clear)
                            .border(.red, width: 2)
                            .frame(height: 70)
                            .dropDestination(for: Color.self) { droppedColors, location in
                                if let color = droppedColors.first {
                                    gridColors[index] = color
                                    return true
                                }
                                return false
                            }
                    }
                }
                .padding()
                
                HStack (spacing: 0){
                    ForEach(colors, id: \.self){ color in
                        Rectangle()
                            .fill(color)
                            .frame(width: 70, height: 70)
                            .draggable(color) {
                                Rectangle()
                                    .fill(color.opacity(0.5))
                                    .frame(width: 50, height: 50)
                            }
                    }
                }
                .frame(height: 200)
            }
            .foregroundStyle(userManager.textColor)
        }
    }
}

#Preview {
    OfficeSorter()
        .environmentObject(UserManager())
}

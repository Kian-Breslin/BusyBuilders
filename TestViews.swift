//
//  TestViews.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 10/02/2025.
//

import SwiftUI
import SwiftData

struct TestViews : View {
    @EnvironmentObject var themeManager : ThemeManager
    
    @State var fakeBusinesses : [BusinessDataModel] = [
        BusinessDataModel(businessName: "Fake Name 1", businessTheme: "red", businessType: "Eco", businessIcon: "circle"),
        BusinessDataModel(businessName: "Fake Name 2", businessTheme: "blue", businessType: "Eco", businessIcon: "triangle"),
        BusinessDataModel(businessName: "Fake Name 3", businessTheme: "green", businessType: "Co-op", businessIcon: "square"),
        BusinessDataModel(businessName: "Fake Name 4", businessTheme: "pink", businessType: "MNC", businessIcon: "hexagon"),
        BusinessDataModel(businessName: "Fake Name 5", businessTheme: "purple", businessType: "MNC", businessIcon: "circle"),
        BusinessDataModel(businessName: "Fake Name 6", businessTheme: "red", businessType: "Co-op", businessIcon: "triangle")
    ]
    
    @State private var isPressed = false
    @State private var trimStart: CGFloat = 0.0
    @State private var trimEnd: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            themeManager.mainColor
                .ignoresSafeArea()
            
            VStack (spacing: 50){
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.red, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                    .frame(width: 150, height: 50)
                    .foregroundStyle(themeManager.textColor)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .trim(from: 0, to: trimEnd)
                            .stroke(Color.white, lineWidth: 5)
                            .frame(width: 150, height: 50)
                            .animation(.bouncy(duration: 5), value: trimEnd)
                    }
                    .onLongPressGesture(minimumDuration: 0.5, pressing: { pressing in
                        if pressing {
                            trimEnd = 1.0
                        } else {
                            trimEnd = 0.0
                        }
                    }, perform: {
                        if trimEnd == 1.0 {
                            print("Completed")
                        }
                    })
                
                RoundedRectangle(cornerRadius: 10)
                    .trim(from: trimStart, to: trimEnd)
                    .stroke(Color.green, lineWidth: 3)
                    .frame(width: 150, height: 50)
                
                
                
                Button("Click Me") {
                    if trimEnd < 1 {
                        trimEnd += 0.1
                    } else {
                        trimEnd = 0
                    }
                }
            }
            .animation(.bouncy(duration: 5), value: trimEnd)
        }
    }
}

#Preview {
    TestViews()
        .environmentObject(ThemeManager())
}

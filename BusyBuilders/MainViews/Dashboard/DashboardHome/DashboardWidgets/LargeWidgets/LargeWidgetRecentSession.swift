//
//  LargeWidgetRecentSession.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 28/07/2025.
//

import SwiftUI
import SwiftData

struct LargeWidgetRecentSession: View {
    @Query var users: [UserDataModel]
    @EnvironmentObject var userManager: UserManager
    let widgetSize = largeWidgetSize
    @State var sessionsArray: [SessionDataModel] = []
    let cirleSizes : [CGPoint : Int] = [
        CGPoint(x: 40,y: 40): 80,
        CGPoint(x: 120,y: 30): 60,
        CGPoint(x: 30,y: 120): 50,
        CGPoint(x: 150,y: 130): 30,
        CGPoint(x: 100,y: 100): 70
    ]
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: widgetSize.width, height: widgetSize.height)
            .foregroundStyle(userManager.mainColor)
            .overlay {
                VStack (alignment: .leading, spacing: 10){
                    Text("Recent Sessions")
                        .font(.headline)
                    
                    ZStack {
                        ForEach(Array(zip(cirleSizes.keys, sessionsArray)), id: \.1.id) { key, session in
                            if let width = cirleSizes[key] {
                                SessionCirle(circleWidth: width, circlePosition: key, sessionTotal: Double(session.total))
                            }
                        }
                    }
                    .frame(width: widgetSize.width-30, height: widgetSize.height-50)
                }
                .frame(width: widgetSize.width-20, height: widgetSize.height-20, alignment: .leading)
                .foregroundStyle(userManager.textColor)
            }
            .onAppear {
                if let user = users.first {
                    sessionsArray = Array(user.sessionHistory.suffix(5))
                }
            }
    }
}

struct SessionCirle: View {
    let circleWidth: Int
    let circlePosition: CGPoint
    let sessionTotal: Double
    let circleColor: Color = getColor(UserManager().accentColor)
    var body: some View {
        Circle()
            .stroke(circleColor, lineWidth: 2)
            .overlay {
                ZStack {
                    Circle()
                        .foregroundStyle(circleColor.opacity(0.3))
                        .frame(width: CGFloat(circleWidth))
                    Text(String(format: "$%.0f", sessionTotal))
                        .font(.system(size: CGFloat(circleWidth) * 0.2, weight: .bold))
                        .foregroundStyle(circleColor)
                }
            }
            .frame(width: CGFloat(circleWidth))
            .position(circlePosition)
    }
}

#Preview {
    LargeWidgetRecentSession()
        .environmentObject(UserManager())
}

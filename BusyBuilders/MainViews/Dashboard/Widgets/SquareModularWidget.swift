//
//  SquareModularWidget.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 21/11/2024.
//

import SwiftUI

struct SquareModularWidget: View {
    
    @EnvironmentObject var themeManager: ThemeManager
    
    @State var selectedScreen = 0
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .foregroundStyle(themeManager.mainColor)
            .frame(width: (screenWidth-30)/2, height: (screenWidth-45)/2)
            .overlay {
                if selectedScreen == 0 {
                    ZStack {
                        Circle()
                            .trim(from: 0, to: 0.8)
                            .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                            .rotationEffect(Angle(degrees: -90))
                            .frame(width: 135)
                            .foregroundStyle(getColor("green").gradient)
                        
                        Circle()
                            .trim(from: 0, to: 0.3)
                            .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                            .rotationEffect(Angle(degrees: -90))
                            .frame(width: 110)
                            .foregroundStyle(getColor("blue").gradient)
                        
                        Circle()
                            .trim(from: 0, to: 0.5)
                            .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                            .rotationEffect(Angle(degrees: -90))
                            .frame(width: 85)
                            .foregroundStyle(getColor("\(themeManager.secondaryColor)").gradient)
                        Circle()
                            .frame(width: 70)
                            .foregroundStyle(themeManager.textColor)
                            .overlay {
                                Text("55")
                                    .foregroundStyle(themeManager.mainColor)
                                    .font(.system(size: 25))
                            }
                    }
                }
                else if selectedScreen == 1 {
                    VStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(getColor("\(themeManager.secondaryColor)"))
                            .frame(width: (screenWidth-45)/2, height: 50)
                            .overlay {
                                HStack {
                                    Text("Thursday")
                                    
                                    Spacer()
                                    
                                    Image(systemName: "calendar")
                                }
                                .padding(.horizontal)
                                .font(.system(size: 20))
                                .foregroundStyle(themeManager.mainColor)

                            }
                            .padding(.top, 5)
                        Spacer()
                        
                        Text("21")
                            .font(.system(size: 60))
                            .fontWeight(.light)
                        
                        Spacer()
                        
                        Text("November")
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .padding(.bottom, 5)
                    }
                    .foregroundStyle(themeManager.textColor)
                }
            }
            .clipped()
    }
}

#Preview {
    SquareModularWidget()
        .environmentObject(ThemeManager())
}

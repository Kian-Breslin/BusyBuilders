//
//  RectangleMediumModularWidget.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 21/11/2024.
//

import SwiftUI

struct RectangleMediumModularWidget: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    let daysOfWeek = ["MON", "TUE", "WED", "THUR", "FRI", "SAT", "SUN"]
    let currentDay = 21
    
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(width: (screenWidth-30), height: (screenWidth - 45) / 2)
            .foregroundStyle(themeManager.mainColor)
            .overlay {
                VStack (spacing: 5){
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(getColor("\(themeManager.secondaryColor)"))
                        .frame(width: (screenWidth-40), height: 50)
                        .overlay {
                            HStack {
                                Text("November")
                                
                                Spacer()
                                
                                Image(systemName: "calendar")
                            }
                            .padding(.horizontal)
                            .font(.system(size: 20))
                            .foregroundStyle(themeManager.mainColor)

                        }
                        .padding(.top, 5)
                    
                    HStack {
                            
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                            ForEach(1..<31){ i in
                                Text("\(i)")
                                    .bold()
                                    .font(.system(size: 12))
                                    .foregroundStyle(i == currentDay ? themeManager.mainColor : themeManager.textColor)
                                    .padding(.vertical, 0.5)
                                    .background(
                                        RoundedRectangle(cornerRadius: 5)
                                            .frame(width: 20, height: 20)
                                            .foregroundStyle(themeManager.textColor)
                                            .opacity(i == currentDay ? 0.7 : 0)
                                    )
                            }
                        }
                        .frame(width: ((screenWidth-60)/3)*2, height: (screenWidth - 175) / 2)
                            
                        
                        RoundedRectangle(cornerRadius: 2)
                            .frame(width: 1, height: (screenWidth - 175) / 2)
                            .foregroundStyle(themeManager.textColor)
                        
                        VStack (spacing: 10){
                            Text("Tuesday")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                            
                            Text("21")
                                .fontWeight(.heavy)
                                .font(.system(size: 35))
                                .foregroundStyle(getColor("\(themeManager.secondaryColor)"))
                            
                            HStack (spacing: 5){
                                Image(systemName: "location.fill")
                                Text("Dublin")
                            }
                            .fontWeight(.light)
                            .font(.system(size: 15))
                        }
                        .frame(width: ((screenWidth-60)/3), height: (screenWidth - 175) / 2)
                        .foregroundStyle(themeManager.textColor)
                    }
                    .frame(width: (screenWidth-40))
                    .padding(.bottom, 5)
                }
            }
    }
}

#Preview {
    RectangleMediumModularWidget()
        .environmentObject(ThemeManager())
}

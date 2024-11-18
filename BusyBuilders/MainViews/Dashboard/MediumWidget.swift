//
//  MediumWidget.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 27/09/2024.
//

import SwiftUI

struct MediumWidget: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var colorName : Color
    @AppStorage("userTextPreference") var userTextPreference: String = "white"
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: (screenWidth-30)/2, height: 130)
            .foregroundStyle(colorName)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 60, height: 80)
                    .rotationEffect(Angle(degrees: -25))
                    .shadow(radius: 5)
                    .overlay {
                        VStack (alignment: .leading) {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 35, height: 5)
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 20, height: 5)
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 25, height: 5)
                        }
                        .foregroundStyle(colorName)
                    }
                    .offset(x: -20)
                    
                
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 60, height: 80)
                    .rotationEffect(Angle(degrees: 0))
                    .overlay {
                        VStack (alignment: .leading) {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 35, height: 5)
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 20, height: 5)
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 25, height: 5)
                        }
                        .foregroundStyle(colorName)
                    }
                    .shadow(radius: 5)
                
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 60, height: 80)
                    .shadow(radius: 5)
                    .overlay {
                        VStack (alignment: .leading) {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 35, height: 5)
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 20, height: 5)
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 25, height: 5)
                        }
                        .foregroundStyle(colorName)
                    }
                    .rotationEffect(Angle(degrees: 15))
                    .offset(x: 20)
            }
            .foregroundStyle(textColor(userTextPreference))
    }
}

#Preview {
    MediumWidget(colorName: Color(red: 244/255, green: 73/255, blue: 73/255))
        .environmentObject(ThemeManager())
}

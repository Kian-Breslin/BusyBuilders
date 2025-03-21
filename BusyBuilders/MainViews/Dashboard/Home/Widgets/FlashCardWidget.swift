//
//  FlashCardWidget.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 14/11/2024.
//

import SwiftUI

struct FlashCardWidget: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @State var subjects = ["Geography", "Math", "History"]
    @State var selectedSubject = 0
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: screenWidth-20, height: 100)
            .foregroundStyle(themeManager.mainColor)
            .overlay {
                if selectedSubject == 0 {
                    HStack {
                        VStack (alignment: .leading, spacing: 5){
                            Text(subjects[0])
                                .foregroundStyle(getColor("\(themeManager.secondaryColor)"))
                                .font(.system(size: 25))
                            Text("Top Score: 20 pts")
                            Text("Total Cards in Deck: 38")
                        }
                        Spacer()
                        
                        flashCardImage()
                            .frame(width: 100, height: 100)
                    }
                    .foregroundStyle(themeManager.textColor)
                    .padding()
                }
            }
    }
}

struct flashCardImage: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 40, height: 60)
                .rotationEffect(Angle(degrees: -25))
                .shadow(radius: 5)
                .overlay {
                    VStack (alignment: .leading) {
                        RoundedRectangle(cornerRadius: 2)
                            .frame(width: 20, height: 2)
                        RoundedRectangle(cornerRadius: 2)
                            .frame(width: 15, height: 2)
                        RoundedRectangle(cornerRadius: 2)
                            .frame(width: 20, height: 2)
                    }
                    .foregroundStyle(getColor("red"))
                }
                .offset(x: -15)
                
            
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 40, height: 60)
                .rotationEffect(Angle(degrees: 0))
                .overlay {
                    VStack (alignment: .leading) {
                        RoundedRectangle(cornerRadius: 2)
                            .frame(width: 20, height: 2)
                        RoundedRectangle(cornerRadius: 2)
                            .frame(width: 15, height: 2)
                        RoundedRectangle(cornerRadius: 2)
                            .frame(width: 20, height: 2)
                    }
                    .foregroundStyle(getColor("red"))
                }
                .shadow(radius: 5)
            
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 40, height: 60)
                .shadow(radius: 5)
                .overlay {
                    VStack (alignment: .leading) {
                        RoundedRectangle(cornerRadius: 2)
                            .frame(width: 20, height: 2)
                        RoundedRectangle(cornerRadius: 2)
                            .frame(width: 15, height: 2)
                        RoundedRectangle(cornerRadius: 2)
                            .frame(width: 20, height: 2)
                    }
                    .foregroundStyle(getColor("red"))
                }
                .rotationEffect(Angle(degrees: 15))
                .offset(x: 15)
        }
    }
}

#Preview {
    FlashCardWidget()
        .environmentObject(ThemeManager())
}

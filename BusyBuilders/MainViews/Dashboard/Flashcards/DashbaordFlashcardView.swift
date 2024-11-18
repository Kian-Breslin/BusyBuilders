//
//  DashbaordFlashcardView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 18/11/2024.
//

import SwiftUI

struct DashbaordFlashcardView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @State var mainColor : Color
    @State var secondaryColor : Color
    @State var textColor : Color
    
    var body: some View {
        ScrollView (showsIndicators: false){
            VStack (alignment: .leading, spacing: 20){
                NavigationLink (destination: FlashCardWidget()){
                    VStack (alignment: .leading, spacing: 5){
                        Text("Weekly Goals")
                            .foregroundStyle(mainColor)
                            .font(.system(size: 15))
                            .opacity(0.7)
                        ScrollView (.horizontal, showsIndicators: false){
                            HStack {
                                ForEach(0..<2) { i in
                                    WeeklyStudyGoal(mainColor: mainColor, secondaryColor: secondaryColor, textColor: textColor)
                                        .containerRelativeFrame(.horizontal, count: 1, spacing: 16)
                                }
                            }
                            .scrollTargetLayout()
                        }
                        .scrollTargetBehavior(.viewAligned)
                    }
                }
                
                VStack (alignment: .leading, spacing: 5){
                    Text("Flash Cards")
                        .foregroundStyle(mainColor)
                        .font(.system(size: 15))
                        .opacity(0.7)
                    
                    NavigationLink( destination: DeckList()){
                        WeeklyStudyGoal(mainColor: mainColor, secondaryColor: secondaryColor, textColor: textColor)
                    }
                }
                
                VStack (alignment: .leading, spacing: 5){
                    Text("Create Flash Cards")
                        .foregroundStyle(mainColor)
                        .font(.system(size: 15))
                        .opacity(0.7)
                    
                    NavigationLink( destination: CreateFlashcard()){
                        WeeklyStudyGoal(mainColor: mainColor, secondaryColor: secondaryColor, textColor: textColor)
                    }
                }

            }
            .padding(.bottom, 35)
            .padding(.top, 15)
            .frame(width: screenWidth-30)
        }

    }
}

#Preview {
    DashbaordFlashcardView(mainColor: getColor("black"), secondaryColor: getColor("red"), textColor: getColor("white"))
        .environmentObject(ThemeManager())
}

//
//  MyStats.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 14/11/2024.
//

import SwiftUI

struct MyStats: View {
    @EnvironmentObject var themeManager: ThemeManager
    var body: some View {
        VStack (alignment: .leading){
            
            VStack (alignment: .leading){
                Text("Total Net Worth")
                    .opacity(0.5)
                    .font(.system(size: 15))
                Text("$1,408,340")
                    .font(.system(size: 35))
            }
            VStack (alignment: .leading){
                Text("Total Time Studied")
                    .opacity(0.5)
                    .font(.system(size: 15))
                HStack (alignment: .bottom){
                    Text("240")
                    Text("hrs")
                        .font(.system(size: 15))
                    Text("48")
                    Text("mins")
                        .font(.system(size: 15))
                    Text("34")
                    Text("secs")
                        .font(.system(size: 15))
                }
                .font(.system(size: 35))
            }
            VStack (alignment: .leading){
                Text("Total Sessions Completed")
                    .opacity(0.5)
                    .font(.system(size: 15))
                Text("533")
                    .font(.system(size: 35))
            }
            VStack (alignment: .leading){
                Text("Longest Streak")
                    .opacity(0.5)
                    .font(.system(size: 15))
                Text("28")
                    .font(.system(size: 35))
            }
            VStack (alignment: .leading){
                Text("Level")
                    .opacity(0.5)
                    .font(.system(size: 15))
                Text("39")
                    .font(.system(size: 35))
            }
            VStack (alignment: .leading){
                Text("Total Badges Earned")
                    .opacity(0.5)
                    .font(.system(size: 15))
                Text("74")
                    .font(.system(size: 35))
            }
            Spacer()
        }
        .foregroundStyle(getColor("white"))
        .frame(width: screenWidth-30, height: (screenHeight-90) / 1.4, alignment: .leading)
    }
}

#Preview {
    MyStats()
        .environmentObject(ThemeManager())
}

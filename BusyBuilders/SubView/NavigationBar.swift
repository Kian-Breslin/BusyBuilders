//
//  TestView1.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 21/05/2024.
//

import SwiftUI

struct NavigationBar: View {
    
    @Binding var selectedView : Int
    @Binding var makeNewBusiness : Bool
    @Binding var startTask : Bool
    
    var imagesList = ["square.grid.2x2", "plus", "play", "chart.bar", "person"]
    var detailsList = ["Dashboard", "Add Business", "Start Task", "Leaderboard", "Portfolio"]
    
    // Selected View
    // Make new Business
    
    var body: some View {
        ZStack (alignment: .top){
            Rectangle()
                .frame(width: 600, height: 90)
                .foregroundStyle(.black)
            
            HStack (alignment: .bottom ,spacing: 25){
                ForEach(0..<5) { i in
                    VStack (spacing: 5) {
                        Image(systemName: "\(imagesList[i])")
                        Text("\(detailsList[i])")
                            .font(.system(size: 10))
                    }
                    .foregroundStyle(Color(red: 197/255, green: 202/255, blue: 205/255))
                    .font(.system(size: 25))
                    .fontWeight(.light)
                    .onTapGesture {
                        selectedView = i
                        print(selectedView)
                        if selectedView == 1 {
                            makeNewBusiness = true
                        }
                        if selectedView == 2 {
                            startTask = true
                        }
                        print(makeNewBusiness)
                    }
                }
            }
            .padding(5)
        }
    }
}

#Preview {
    NavigationBar(selectedView: .constant(0), makeNewBusiness: .constant(false), startTask: .constant(false))
}

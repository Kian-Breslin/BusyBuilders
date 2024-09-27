//
//  Dashboard.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 23/09/2024.
//

import SwiftUI

struct Dashboard: View {
    var body: some View {
        ZStack {
            Color(red: 197/255, green: 202/255, blue: 205/255)
                .ignoresSafeArea()
            
            VStack {
                // Top of Screen
                HStack {
                    HStack {
                        VStack (alignment: .leading){
                            Text("Hello!")
                                .font(.system(size: 25))
                                .fontWeight(.light)
                            Text("Kian Breslin")
                                .font(.system(size: 35))
                        }
                        Image(systemName: "hand.raised")
                            .font(.system(size: 40))
                            .rotationEffect(Angle(degrees: -35))
                            .offset(y: 9)
                    }
                    Spacer()
                    
                    Image(systemName: "circle.fill")
                        .font(.system(size: 60))
                        .fontWeight(.thin)
                }
                .padding(.horizontal,10)
                
                // Middle of Screen
                VStack {
                    HStack {
                        ScrollView (.horizontal){
                            HStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: (screenWidth/2)-15, height: 100)
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: (screenWidth/2)-15, height: 100)
                            }
                            .scrollTargetLayout()
                        }
                        .scrollTargetBehavior(.viewAligned)
                       
                        ScrollView (.horizontal){
                            HStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: (screenWidth/2)-15, height: 100)
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: (screenWidth/2)-15, height: 100)
                            }
                            .scrollTargetLayout()
                        }
                        .scrollTargetBehavior(.viewAligned)
                    }
                    .frame(width: screenWidth-20, height: 100)
                    
                    ScrollView {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: screenWidth-20, height: 150)
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: screenWidth-20, height: 150)
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: screenWidth-20, height: 150)
                    }
                    .frame(width: screenWidth, height: 410)
                }
                Spacer()
            }
            .padding(.vertical, 35)
        }
    }
}

#Preview {
    Dashboard()
}

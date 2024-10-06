//
//  MessagesTopNavigationBar.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 27/09/2024.
//

import SwiftUI

struct MessagesTopNavigationBar: View {
    
    @State var topBarHeight = 210
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: screenWidth, height: CGFloat(topBarHeight))
                .foregroundStyle(Color(red: 244/255, green: 73/255, blue: 73/255))
            
            VStack {
                HStack (spacing: 70){
                    Image(systemName: "person.3")
                        .font(.system(size: 20))
                    Text("Messages")
                        .font(.system(size: 30))
                    Circle()
                        .frame(width:60)
                }
                
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width:60, height: 60)
                        .overlay {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 20))
                                .foregroundStyle(.black)
                                .onTapGesture {
                                    if topBarHeight < 399 {
                                        topBarHeight = 400
                                    } else {
                                        topBarHeight = 210
                                    }
                                }
                        }
                    
                    ScrollView (.horizontal){
                        HStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width:60, height: 60)
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width:60, height: 60)
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width:60, height: 60)
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width:60, height: 60)
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width:60, height: 60)
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width:60, height: 60)
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width:60, height: 60)
                        }
                    }
                }
            }
            .border(Color.blue)
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    MessagesTopNavigationBar()
}

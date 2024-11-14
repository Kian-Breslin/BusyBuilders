//
//  TopNavigation.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 14/11/2024.
//

import SwiftUI

struct TopNavigation: View {
    
    @State var Title : String
    @State var buttonImages : [String]
    @State var buttonText : [String]
    
    
    var body: some View {
        VStack {
            // Top Header
            HStack {
                VStack (alignment: .leading){
                    Text(Title)
                        .font(.system(size: 35))
                        .fontWeight(.bold)
                }
                .onTapGesture {
                    
                }
                Spacer()
                HStack (spacing: 15){
                    ZStack {
                        Image(systemName: "bell.fill")
                        Image(systemName: "2.circle.fill")
                            .font(.system(size: 15))
                            .offset(x: 10, y: -10)
                            .onTapGesture {
                                
                            }
                    }
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 40, height: 40)
                        .overlay(content: {
                            Image("userImage-2")
                                .resizable()
                                .frame(width: 40,height: 40)
                        })
                        .onTapGesture {
                            
                            
                        }
                }
                .font(.system(size: 25))
            }
            .frame(width: screenWidth-30, height: 80)
            
            HStack {
                ForEach(0..<4){ i in
                    Spacer()
                    VStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 60, height: 60)
                            .overlay {
                                Image(systemName: buttonImages[i])
                                    .font(.system(size: 30))
                                    .foregroundStyle(getColor("black"))
                                    
                            }
                            .onTapGesture {
                                
                            }
                        Text(buttonText[i])
                    }
                    .frame(width: (screenWidth-60)/4, height: 80)
                    Spacer()
                }
            }
            .font(.system(size: 12))
            .foregroundStyle(getColor("white"))
            .frame(width: screenWidth-30, height: 100)
        }
        .frame(width: screenWidth-30, height: 180)
    }
}

#Preview {
    TopNavigation(Title: "Dashboard", buttonImages: ["dollarsign","dollarsign.arrow.circlepath","creditcard","archivebox"], buttonText: ["Send","Withdraw","Bank","Inventory"])
}

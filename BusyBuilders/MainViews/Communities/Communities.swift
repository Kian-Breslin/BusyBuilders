//
//  Communities.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 23/09/2024.
//

import SwiftUI

struct Communities: View {
    
    @EnvironmentObject var themeManager: ThemeManager
    @State var buttonImages = ["house", "archivebox", "banknote", "newspaper"]
    @State var buttonText = ["Home", "Inventory", "Bank", "News"]
    @State var selectedScreen = "house"
    
    @State var colorMode : Bool = true
    // Dark Mode
    @State var mainColor = ThemeManager().mainColor
    @State var secondaryColor = Color(red: 85/255, green: 85/255, blue: 85/255)
    @State var textColor = ThemeManager().textColor
    
    // Light Mode
    @State var lightMainColor = Color(red: 255/255, green: 247/255, blue: 214/255)
    @State var lightModeSecondaryColor = Color(red: 255/255, green: 255/255, blue: 249/255)
    
    
    var body: some View {
        ZStack {
            mainColor
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    // Top Header
                    HStack {
                        Text("Dashboard")
                            .font(.system(size: 35))
                            .fontWeight(.bold)
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
                                    if colorMode == true {
                                        mainColor = Color(red: 235/255, green: 235/255, blue: 235/255)
                                        secondaryColor = Color(red: 255/255, green: 255/255, blue: 249/255)
                                        textColor = themeManager.mainColor
                                        colorMode.toggle()
                                    } else {
                                        mainColor = ThemeManager().mainColor
                                        secondaryColor = Color(red: 85/255, green: 85/255, blue: 85/255)
                                        textColor = ThemeManager().textColor
                                        colorMode.toggle()
                                    }
                                    
                                }
                        }
                        .font(.system(size: 25))
                    }
                    .frame(width: screenWidth-20, height: 60)
                    .foregroundStyle(textColor)
                    
                    HStack {
                        ForEach(0..<4){ i in
                            VStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 60, height: 60)
                                    .foregroundStyle(secondaryColor)
                                    .overlay {
                                        Image(systemName: buttonImages[i] == selectedScreen ? "\(buttonImages[i]).fill" : "\(buttonImages[i])")
                                            .font(.system(size: 30))
                                            .foregroundStyle(textColor)
                                            
                                    }
                                    .onTapGesture {
                                        selectedScreen = buttonImages[i]
                                    }
                                Text(buttonText[i])
                                    .font(.system(size: 10))
                                    .scaledToFit()
                                    .foregroundStyle(textColor)
                            }
                            .frame(width: 60, height: 80)
                            
                            if i < 3 {
                                Spacer()
                            }
                        }
                    }
                    .font(.system(size: 12))
                    .foregroundStyle(themeManager.textColor)
                    .frame(width: screenWidth-20, height: 100)
                }
                .frame(width: screenWidth-20, height: 160)
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: screenWidth)
                    .foregroundStyle(secondaryColor)
                    .overlay {
                        VStack (alignment: .leading){
                            
                        }
                        .frame(width: screenWidth-20, alignment: .leading)
                    }
            }
        }
    }
}

#Preview {
    Communities()
        .modelContainer(for: UserDataModel.self)
        .environmentObject(ThemeManager())
}

//
//  Portfolio.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 23/09/2024.
//

import SwiftUI
import SwiftData

struct Portfolio: View {
    
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.modelContext) var context
    @Query var users: [UserDataModel]
    @Query var businesses: [BusinessDataModel]
    
    @State var selectedScreen = "building"
    
    @State var searchForUser = ""
    @State var selectedBusinessToDelete : BusinessDataModel?
    @State var confirmDeleteBusiness = false
    
    @State var Title = "Portfolio"
    @State var buttonImages = ["person", "building", "building.columns", "banknote"]
    @State var buttonText = ["My Stats", "My Businesses", "My City", "Investments"]

    var body: some View {
        NavigationView {
            ZStack {
                themeManager.mainColor
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        // Top Header
                        HStack {
                            Text(Title)
                                .font(.system(size: 35))
                                .foregroundStyle(themeManager.textColor)
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
                                .foregroundStyle(themeManager.textColor)
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle(themeManager.textColor)
                                    .overlay(content: {
                                        Image("userImage-2")
                                            .resizable()
                                            .frame(width: 40,height: 40)
                                    })
                                    .onTapGesture {
                                        let newBusiness = BusinessDataModel(businessName: "Cozy Coffee", businessTheme: "red", businessType: "Eco-Friendly", businessIcon: "triangle")
                                        context.insert(newBusiness)
                                        
                                        do {
                                            try context.save()
                                        } catch {
                                            print("Couldnt create quick business")
                                        }
                                        
                                    }
                            }
                            .font(.system(size: 25))
                        }
                        .frame(width: screenWidth-30, height: 60)
                        
                        HStack {
                            ForEach(0..<4) { i in
                                VStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 60, height: 60)
                                        .overlay {
                                            Image(systemName: buttonImages[i] == selectedScreen ? "\(buttonImages[i]).fill" : "\(buttonImages[i])")
                                                .font(.system(size: 30))
                                                .foregroundStyle(themeManager.mainColor)
                                        }
                                        .onTapGesture {
                                            selectedScreen = buttonImages[i]
                                        }
                                    Text(buttonText[i])
                                        .font(.system(size: 10))
                                        .scaledToFit()
                                }
                                .frame(width: 60, height: 80)
                                
                                // Add a spacer after each VStack, except for the last one
                                if i < 3 {
                                    Spacer()
                                }
                            }
                        }
                        .font(.system(size: 12))
                        .foregroundStyle(themeManager.textColor)
                        .frame(width: screenWidth - 30, height: 100)
                    }
                    .frame(width: screenWidth-30, height: 160)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: screenWidth)
                        .foregroundStyle(themeManager.textColor)
                        .overlay {
                            if selectedScreen == "person" {
                                MyStats()
                            }
                            else if selectedScreen == "building" {
                                MyBusinesses()
                            }
                            else if selectedScreen == "building.columns" {
                                Text("My City")
                                    .foregroundStyle(.black)
                            }
                            else if selectedScreen == "chart.line.flattrend.xyaxis" {
                                Text("Investments")
                                    .foregroundStyle(.black)
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    Portfolio()
        .environmentObject(UserManager())
        .environmentObject(ThemeManager())
}

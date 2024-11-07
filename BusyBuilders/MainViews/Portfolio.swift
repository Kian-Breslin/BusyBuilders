//
//  Portfolio.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 23/09/2024.
//

import SwiftUI
import SwiftData

struct Portfolio: View {
    
    @AppStorage("userColorPreference") var userColorPreference: String = "red"
    @Environment(\.modelContext) var context
    @Query var users: [UserDataModel]
    @Query var businesses: [BusinessDataModel]
    
    @State var isNewBusinessSheetShowing = false
    
    @State var selectedScreen = "building"
    @State var addNewBusiness = false
    
    let colorNames: [String] = ["Red", "Blue", "Green", "Yellow", "Pink"]
    let iconNames: [String] = ["triangle", "diamond", "pentagon", "shield", "rhombus"]
    let businessTypes: [String] = ["Eco-Friendly", "Corporate", "Innovative"]
    @State var businessName = "New Business"
    @State var businessTheme = "Red"
    @State var businessIcon = "triangle"
    @State var businessType = "Eco-Friendly"
    @State var owners = ""
    
    @State var searchForUser = ""
    
    // For Developement
    let devNames = ["Math Masters","Eco Innovators","Science Solutions","Code Creators","Design Depot","Robotics Realm","Tech Repair Hub","Game Forge","AI Insights","Physics Powerhouse"]

    var body: some View {
        NavigationView {
            ZStack {
                getColor(userColorPreference)
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        // Top Header
                        HStack {
                            VStack (alignment: .leading){
                                Text("Portfolio")
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
                        .padding(15)
                        
                        HStack {
                            VStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 60, height: 60)
                                    .overlay {
                                        Image(systemName: "\(selectedScreen == "person" ? "person.fill" : "person")")
                                            .font(.system(size: 30))
                                            .foregroundStyle(getColor(userColorPreference))
                                    }
                                    .onTapGesture {
                                        selectedScreen = "person"
                                    }
                                Text("My Stats")
                            }
                            Spacer()
                            VStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 60, height: 60)
                                    .overlay {
                                        Image(systemName: "\(selectedScreen == "building" ? "building.fill" : "building")")
                                            .font(.system(size: 30))
                                            .foregroundStyle(getColor(userColorPreference))
                                    }
                                    .onTapGesture {
                                        selectedScreen = "building"
                                    }
                                Text("My Businesses")
                            }
                            Spacer()
                            VStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 60, height: 60)
                                    .overlay {
                                        Image(systemName: "\(selectedScreen == "building.columns" ? "building.columns.fill" : "building.columns")")
                                            .font(.system(size: 30))
                                            .foregroundStyle(getColor(userColorPreference))
                                    }
                                    .onTapGesture {
                                        selectedScreen = "building.columns"
                                    }
                                Text("My City")
                            }
                            Spacer()
                            VStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 60, height: 60)
                                    .overlay {
                                        Image(systemName: "\(selectedScreen == "chart.line.flattrend.xyaxis" ? "chart.line.uptrend.xyaxis" : "chart.line.flattrend.xyaxis")")
                                            .font(.system(size: 30))
                                            .foregroundStyle(getColor(userColorPreference))
                                    }
                                    .onTapGesture {
                                        selectedScreen = "chart.line.flattrend.xyaxis"
                                    }
                                Text("Investments")
                            }
                        }
                        .padding(.horizontal, 15)
                        .font(.system(size: 12))
                    }

                    
                    // List existing businesses
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: screenWidth, height: screenHeight/1.45)
                            .foregroundStyle(getColor("white"))
                        
                        if selectedScreen == "person" {
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
                            .foregroundStyle(.black)
                            .frame(width: screenWidth-30, height: (screenHeight-90) / 1.4, alignment: .leading)
                        }
                        else if selectedScreen == "building" {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    ForEach(businesses) { business in
                                        BusinessCard(business: business)
                                            .containerRelativeFrame(.horizontal, count: 1, spacing: 16)
                                    }
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: screenWidth - 60, height: 520)
                                        .foregroundStyle(getColor("black"))
                                        .containerRelativeFrame(.horizontal, count: 1, spacing: 16)
                                        .overlay {
                                            Text("Add New User")
                                        }
                                        .onTapGesture {
                                            isNewBusinessSheetShowing.toggle()
                                        }
                                }
                                .scrollTargetLayout()
                            }
                            .scrollTargetBehavior(.viewAligned)                        }
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
        .sheet(isPresented: $isNewBusinessSheetShowing) {
            CreateNewBusiness()
                .presentationDetents([.fraction(0.8)])
        }
    }
}

#Preview {
    Portfolio()
        .modelContainer(for: UserDataModel.self, inMemory: true)
}

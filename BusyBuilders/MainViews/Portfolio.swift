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
    @State var selectedBusinessToDelete : BusinessDataModel?
    @State var confirmDeleteBusiness = false
    
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
                            Text("Portfolio")
                                .font(.system(size: 35))
                                .fontWeight(.bold)
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
                            }
                            .font(.system(size: 25))
                        }
                        
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
                            .frame(width: 60, height: 80)
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
                            .frame(width: 60, height: 80)
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
                            .frame(width: 60, height: 80)
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
                            .frame(width: 60, height: 80)
                        }
                        .frame(width: screenWidth-30, height: 80)
                        .font(.system(size: 12))
                    }
                    .frame(width: screenWidth-30, height: 180)

                    
                    // List existing businesses
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: screenWidth, height: screenHeight/1.5)
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
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 250, height: 150)
                                .foregroundStyle(getColor("black"))
                                .overlay {
                                    VStack {
                                        Text("Confirm Deletion")
                                            .bold()
                                            .foregroundStyle(getColor("white"))
                                        Spacer()
                                        Text("Are you sure you want to delete \(selectedBusinessToDelete?.businessName ?? "Name")?")
                                            .font(.system(size: 15))
                                            .multilineTextAlignment(.center)
                                       
                                        Spacer()
                                        HStack {
                                            Text("Back")
                                                .font(.system(size: 20))
                                                .foregroundStyle(getColor("blue"))
                                                .frame(width: 120)
                                                .onTapGesture {
                                                    confirmDeleteBusiness.toggle()
                                                }
                                            Rectangle()
                                                .frame(width: 2, height: 20)
                                                .opacity(0.5)
                                                .foregroundStyle(getColor("white"))
                                            Text("Confirm")
                                                .foregroundStyle(getColor("red"))
                                                .font(.system(size: 20))
                                                .frame(width: 120)
                                                .onTapGesture {
                                                    print("Deleted: \(selectedBusinessToDelete!)")
                                                    context.delete(selectedBusinessToDelete!)
                                                    do {
                                                        try context.save()
                                                        confirmDeleteBusiness.toggle()
                                                    } catch {
                                                        print("Error Deleting Business")
                                                    }
                                                }
                                        }
                                    }
                                    .padding()
                                    .foregroundStyle(getColor("white"))
                                }
                                .opacity(confirmDeleteBusiness ? 1 : 0)
                                .zIndex(99)
                            ScrollView {
                                VStack {
                                    ForEach(businesses){ b in 
                                        NavigationLink(destination : BusinessNavigationDestination(business: b)){
                                            BusinessListItem(business: b)
                                                .onLongPressGesture(minimumDuration: 0.5) {
                                                    selectedBusinessToDelete = b
                                                    confirmDeleteBusiness.toggle()
                                                }
                                                .sensoryFeedback(.impact(flexibility: .soft, intensity: 50), trigger: confirmDeleteBusiness)
                                        }
                                    }
                                }
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: screenWidth-30, height: 100)
                                    .foregroundStyle(getColor("black"))
                                    .overlay {
                                        Text("Click here to add a Business")
                                            .opacity(0.7)
                                            .font(.system(size: 25))
                                    }
                                    .onTapGesture {
                                        let n = randomNumber(in: 0...4)
                                        let t = randomNumber(in: 0...2)
                                        let newBusiness = BusinessDataModel(businessName: "\(devNames[n])", businessTheme: "\(colorNames[n])", businessType: "\(businessTypes[t])", businessIcon: "\(iconNames[n])",owners: [UserDataModel(username: "Kian_17", name: "Kian", email: "Kianbreslin@gmail.com"),UserDataModel(username: "Kim_01", name: "Kimberly", email: "kimberly01leon@gmail.com")], investors: [
                                            UserDataModel(username: "Kimmy_9", name: "Kim", email: "Kim@gmail.com"),
                                            UserDataModel(username: "Jim_00", name: "Jim", email: "Jim@gmail.com"),
                                            UserDataModel(username: "Jack_99", name: "Jack", email: "Jack@gmail.com"),
                                            UserDataModel(username: "LilPimmy", name: "Pim", email: "Pim@gmail.com"),
                                            UserDataModel(username: "LilTimmy", name: "Tim", email: "Tim@gmail.com"),
                                            UserDataModel(username: "LilYimmy", name: "Yim", email: "Yim@gmail.com")
                                        ])

                                        
                                        context.insert(newBusiness)
                                        print("New Business Added")
                                    }
                            }
                            .blur(radius: confirmDeleteBusiness ? 5 : 0)
                            .padding(.top, 15)
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
                    Spacer()
                }
                
            }
        }
        .sheet(isPresented: $isNewBusinessSheetShowing) {
            CreateNewBusiness()
                .presentationDetents([.fraction(0.8)])
        }
    }
}

struct test: View {
    var body: some View {
        Text("It Worked")
    }
}


#Preview {
    Portfolio()
        .modelContainer(for: UserDataModel.self, inMemory: true)
}

//
//  BusinessCard.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 04/11/2024.
//

import SwiftUI

struct BusinessCard: View {
    
    @Environment(\.modelContext) var context
    @State var business : BusinessDataModel
    @State var isInfoSelected = false
    @State var isEditInfo = false
    @State var isShowSessions = false
    let badgeSymbols = [
        "star",      // 10-day streak
        "dollarsign", // Earning over $10,000
        "clock",            // 10+ sessions
        "flame",            // High streak count
        "calendar",  // Monthly participation
        "trophy",           // Reaching a milestone
        "target",                // Setting and achieving goals
        "checkmark.seal",   // Completing a task or goal
        "rosette",               // Special recognition or high score
        "bolt"       // High activity or engagement
    ]
    let colorNames: [String] = ["Red", "Blue", "Green", "Yellow", "Pink", "Purple"]
    let iconNames: [String] = ["triangle", "diamond", "pentagon", "shield", "rhombus"]
    
    @State var isOwner = true
    @State var isAddNewUserFromEdit = false
    @State var newUser = ""
    
    
    // Delete User
    @State var deletingUserIndex = 0
    @State var confirmDelete = false
    @State var deletingUser = ""
    
    @State var abtest = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: screenWidth-60, height: 450)
            .foregroundStyle(getColor("black"))
            .overlay {
                
                DeleteConfirmation(Business: $business, deletingUserIndex: $deletingUserIndex, user: $deletingUser, confirm: $confirmDelete)
                    .zIndex(100)
                    .opacity(confirmDelete ? 1 : 0)
                
                VStack (alignment: .leading){
                    // Top Icon & Title
                    HStack (spacing: 15){
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 130, height: 130)
                            .foregroundStyle(getColor("white"))
                            .overlay {
                                Image(systemName: business.businessIcon)
                                    .foregroundStyle(getColor(business.businessTheme))
                                    .font(.system(size: 100))
                            }
                        
                        VStack (alignment: .leading){
                            
                            if isEditInfo {
                                TextField("\(business.businessName)",text: $business.businessName)
                                    .font(.system(size: 28))
                            } else {
                                Text("\(business.businessName)")
                                    .font(.system(size: 28))
                            }
                            
                            Spacer()
                            
                            VStack (alignment: .leading){
                                Text("Total Net Worth")
                                    .font(.system(size: 12))
                                    .opacity(0.7)
                                Text("$\(business.netWorth, specifier: "%.f")")
                                    .font(.system(size: 25))
                            }
                            
                            HStack {
                                VStack (alignment: .leading){
                                    Text("Level")
                                        .font(.system(size: 12))
                                        .opacity(0.7)
                                    Text("\(getLevelFromSec(business.businessLevel))")
                                        .font(.system(size: 25))
                                }
                                Spacer()
                                VStack (alignment: .center){
                                    Text("Insurance")
                                        .font(.system(size: 12))
                                        .opacity(0.7)
                                    Text("\(getLevelFromSec(business.insuranceLevel))")
                                        .font(.system(size: 25))
                                }
                                Spacer()
                                VStack (alignment: .trailing){
                                    Text("Security")
                                        .font(.system(size: 12))
                                        .opacity(0.7)
                                    Text("\(getLevelFromSec(business.securityLevel))")
                                        .font(.system(size: 25))
                                }
                            }
                        }
                        .frame(height: 130)
                    }
                    // State & Button Change
                    HStack {
                        VStack (alignment: .leading, spacing: 0){
                            Text("\(isInfoSelected ? "Business Details" : "Business Stats")")
                                .font(.system(size: 20))
                            
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: isInfoSelected ? 145 : 130, height: 2)
                                .foregroundStyle(getColor(business.businessTheme))
                        }
                        
                        Spacer()
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 70, height: 30)
                            .foregroundStyle(getColor(business.businessTheme))
                            .overlay {
                                Text("\(isInfoSelected ? "Stats" : "Details")")
                            }
                            .onTapGesture {
                                isInfoSelected.toggle()
                            }
                    }
                    // Show Stats
                    if !isInfoSelected {
                        VStack (alignment: .leading){
                            VStack (alignment: .leading){
                                Text("Total Time Studied")
                                    .font(.system(size: 12))
                                    .opacity(0.5)
                                HStack (alignment: .bottom){
                                    Text("\(timeComponents(from: business.time)[0])")
                                        .font(.system(size: 25))
                                    Text("hrs")
                                        .font(.system(size: 15))
                                    Text("\(timeComponents(from: business.time)[1])")
                                        .font(.system(size: 25))
                                    Text("mins")
                                        .font(.system(size: 15))
                                    Text("\(timeComponents(from: business.time)[2])")
                                        .font(.system(size: 25))
                                    Text("secs")
                                        .font(.system(size: 15))
                                }
                            }
                            VStack (alignment: .leading){
                                Text("Total Sessions Completed")
                                    .font(.system(size: 12))
                                    .opacity(0.5)
                                Text("\(business.sessionHistory.count)")
                                    .font(.system(size: 25))
                            }
                            HStack {
                                VStack (alignment: .leading){
                                    Text("Longest Streak")
                                        .font(.system(size: 12))
                                        .opacity(0.5)
                                    Text("0")
                                        .font(.system(size: 25))
                                }
                                VStack (alignment: .leading){
                                    Text("Current Streak")
                                        .font(.system(size: 12))
                                        .opacity(0.5)
                                    Text("0")
                                        .font(.system(size: 25))
                                }
                            }
                            VStack {
                                VStack (alignment: .leading){
                                    Text("Badges")
                                        .font(.system(size: 12))
                                        .opacity(0.5)
                                    ScrollView (.horizontal){
                                        HStack {
                                            RoundedRectangle(cornerRadius: 5)
                                                .frame(width: 35, height: 35)
                                                .overlay {
                                                    Image(systemName: "flag")
                                                        .foregroundStyle(getColor(business.businessTheme))
                                                }
                                            
                                            ForEach(business.badges.indices, id: \.self){ badge in
                                                RoundedRectangle(cornerRadius: 5)
                                                    .frame(width: 35, height: 35)
                                                    .overlay {
                                                        Image(systemName: "\(badgeSymbols[badge])")
                                                            .foregroundStyle(getColor(business.businessTheme))
                                                    }
                                            }
                                        }
                                    }
                                }
                            }
                            Spacer()
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundStyle(getColor(business.businessTheme))
                                .frame(width: screenWidth-90, height: 40)
                                .overlay{
                                    Text("Show Sessions")
                                        .foregroundStyle(getColor("white"))
                                }
                                .onTapGesture {
                                    isShowSessions.toggle()
                                }
                        }
                    }
                    else {
                        // Edit Business Details
                        if isEditInfo {
                            VStack(alignment: .leading) {
                                VStack (alignment: .leading, spacing: 2){
                                    Text("Business Theme")
                                        .font(.system(size: 12))
                                        .opacity(0.5)
                                    HStack (spacing: 15){
                                        ForEach(0..<5){ i in
                                            RoundedRectangle(cornerRadius: 5)
                                                .frame(width: 50, height: 30)
                                                .foregroundStyle(getColor("black"))
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 5)
                                                        .foregroundStyle(.gray)
                                                        .frame(width: 55, height: 25)
                                                        .overlay {
                                                                Text("\(colorNames[i])").tag(colorNames[i])
                                                                    .font(.system(size: 15))
                                                                    .bold()
                                                                    .foregroundStyle(getColor(colorNames[i] == business.businessTheme ? business.businessTheme : "white"))
                                                    }
                                                    .onTapGesture {
                                                        business.businessTheme = colorNames[i]
                                                    }
                                                }
                                        }
                                    }

                                }
                                VStack (alignment: .leading, spacing: 2){
                                    Text("Business Icon")
                                        .font(.system(size: 12))
                                        .opacity(0.5)
                                    HStack (spacing: 15){
                                        ForEach(0..<5){ i in
                                            RoundedRectangle(cornerRadius: 5)
                                                .frame(width: 50, height: 30)
                                                .foregroundStyle(getColor("black"))
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 5)
                                                        .foregroundStyle(.gray)
                                                        .frame(width: 55, height: 25)
                                                        .overlay {
                                                            Image(systemName: "\(iconNames[i])").tag(iconNames[i])
                                                                    .font(.system(size: 20))
                                                                    .bold()
                                                                    .foregroundStyle(getColor(iconNames[i] == business.businessIcon ? business.businessTheme : "white"))
                                                    }
                                                    .onTapGesture {
                                                        business.businessIcon = iconNames[i]
                                                    }
                                                }
                                        }
                                    }
                                }
                                VStack (alignment: .leading, spacing: 2){
                                    Text("Owners - Hold to Delete")
                                        .opacity(0.5)
                                        .font(.system(size: 12))
                                    ScrollView (.horizontal, showsIndicators: false){
                                        HStack {
                                            ForEach(business.Owners.indices, id: \.self) { owner in
                                                RoundedRectangle(cornerRadius: 10)
                                                    .frame(width: 80, height: 25)
                                                    .foregroundStyle(.gray)
                                                    .overlay {
                                                        Text("\(business.Owners[owner].username)")
                                                            .foregroundStyle(.white)
                                                    }
                                            }
                                            RoundedRectangle(cornerRadius: 10)
                                                .frame(width: 80, height: 25)
                                                .foregroundStyle(.gray)
                                                .overlay{
                                                    Image(systemName: "plus")
                                                        .foregroundStyle(.white)
                                                }
                                                .onTapGesture {
                                                    isAddNewUserFromEdit.toggle()
                                                    isOwner = true
                                                }
                                        }
                                    }
                                }
                                
                                VStack (alignment: .leading, spacing: 2){
                                    Text("Investors - Hold to Delete")
                                        .opacity(0.5)
                                        .font(.system(size: 12))
                                    ScrollView (.horizontal, showsIndicators: false){
                                        HStack {
                                            ForEach(business.investors.indices, id: \.self) { investor in
                                                RoundedRectangle(cornerRadius: 10)
                                                    .frame(width: 80, height: 25)
                                                    .foregroundStyle(.gray)
                                                    .overlay {
                                                        Text("\(business.investors[investor].username)")
                                                            .foregroundStyle(.white)
                                                            .padding(5)
                                                    }
                                                    .onLongPressGesture {
                                                        print("Delete User")
                                                        deletingUser = business.investors[investor].username
                                                        confirmDelete = true
                                                    }
                                            }
                                            RoundedRectangle(cornerRadius: 10)
                                                .frame(width: 80, height: 25)
                                                .foregroundStyle(.gray)
                                                .overlay{
                                                    Image(systemName: "plus")
                                                        .foregroundStyle(.white)
                                                }
                                                .onTapGesture {
                                                    isAddNewUserFromEdit.toggle()
                                                    isOwner = false
                                                }
                                        }
                                    }
                                }
                            }
                            Spacer()
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundStyle(getColor(business.businessTheme))
                                .frame(width: screenWidth-90, height: 40)
                                .overlay{
                                    Text("Save")
                                        .foregroundStyle(getColor("white"))
                                }
                                .onTapGesture {
                                    do {
                                        print("Saved Business")
                                        print("\(business.businessTheme)")
                                        try context.save()
                                        isEditInfo = false
                                        
                                    } catch {
                                        print("Failed to save new business: \(error)")
                                    }
                                }
                        }
                        // Show Business Details
                        else {
                            VStack(alignment: .leading) {
                                VStack (alignment: .leading, spacing: 2){
                                    Text("Business Theme")
                                        .font(.system(size: 12))
                                        .opacity(0.5)
                                    Text("\(business.businessTheme)")
                                        .font(.system(size: 25))

                                }
                                VStack (alignment: .leading, spacing: 2){
                                    Text("Business Icon")
                                        .font(.system(size: 12))
                                        .opacity(0.5)
                                    Image(systemName: "\(business.businessIcon)")
                                        .font(.system(size: 25))
                                }
                                VStack (alignment: .leading, spacing: 2){
                                    Text("Owners")
                                        .opacity(0.5)
                                        .font(.system(size: 12))
                                    ScrollView (.horizontal, showsIndicators: false){
                                        HStack {
                                            ForEach(business.Owners.indices, id: \.self) { owner in
                                                RoundedRectangle(cornerRadius: 10)
                                                    .frame(width: 80, height: 25)
                                                    .foregroundStyle(.gray)
                                                    .overlay {
                                                        Text("\(business.Owners[owner].username)")
                                                            .foregroundStyle(.white)
                                                    }
                                            }
                                        }
                                    }
                                }
                                VStack (alignment: .leading, spacing: 2){
                                    Text("Investors")
                                        .opacity(0.5)
                                        .font(.system(size: 12))
                                    ScrollView (.horizontal, showsIndicators: false){
                                        HStack {
                                            ForEach(business.investors.indices, id: \.self) { investor in
                                                RoundedRectangle(cornerRadius: 10)
                                                    .frame(width: 80, height: 25)
                                                    .foregroundStyle(.gray)
                                                    .overlay {
                                                        Text("\(business.investors[investor].username)")
                                                            .foregroundStyle(.white)
                                                            .padding(5)
                                                    }
                                                    .onLongPressGesture {
                                                        print("Delete User")
                                                        deletingUser = business.investors[investor].username
                                                        confirmDelete = true
                                                    }
                                                }
                                            if business.investors.isEmpty {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .frame(width: 80, height: 25)
                                                    .foregroundStyle(getColor("black"))
                                            }
                                        }
                                    }
                                }
                                Spacer()
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(getColor(business.businessTheme))
                                    .frame(width: screenWidth-90, height: 40)
                                    .overlay{
                                        Text("Edit")
                                            .foregroundStyle(getColor("white"))
                                    }
                                    .onTapGesture {
                                        isEditInfo.toggle()
                                    }
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .sheet(isPresented: $isShowSessions, content: {
                Sessions(business: business)
            })
            .sheet(isPresented: $isAddNewUserFromEdit) {
                
                addNewUserToBusiness(newUser: $newUser, isOwner: $isOwner, isAddNewUserFromEdit: $isAddNewUserFromEdit, business: $business)
                    .padding()
                    .presentationDetents([.fraction(0.2)])
            }
            .onLongPressGesture(minimumDuration: 1.0) {
                print("Delete Current Business : \(business.businessName)")
                
                context.delete(business)
                
                do {
                    try context.save()
                } catch {
                    print("There was an error deleting your Business, Try again!")
                }
            }
        
    }
}

#Preview {
    BusinessCard(business: BusinessDataModel(
        businessName: "Kians Shop",
        businessTheme: "Blue",
        businessType: "Economic",
        businessIcon: "triangle",
        owners: [UserDataModel(username: "Kian_17", name: "Kian", email: "Kianbreslin@gmail.com")],
        time: 9360,
        cashPerMin: 3000,
        netWorth: 6000,
        investors: [
            UserDataModel(username: "LilKimmy", name: "Kim", email: "Kim@gmail.com"),
            UserDataModel(username: "LilJimmy", name: "Jim", email: "Jim@gmail.com"),
            UserDataModel(username: "LilLimmy", name: "Lim", email: "Lim@gmail.com"),
            UserDataModel(username: "LilPimmy", name: "Pim", email: "Pim@gmail.com"),
            UserDataModel(username: "LilTimmy", name: "Tim", email: "Tim@gmail.com"),
            UserDataModel(username: "LilRimmy", name: "Rim", email: "Rim@gmail.com")
        ],
        badges: ["10 Days Streak", "$1000 Earned", "First Upgrade"],
        sessionHistory:
            [SessionDataModel(
                id: UUID(),
                sessionDate: Date.now,
                sessionStart: formatFullDateTime(date: Date()),
                sessionEnd: formatFullDateTime(date: Date()),
                totalStudyTime: 3600, businessId: UUID()),
             SessionDataModel(
                 id: UUID(),
                 sessionDate: Date.now,
                 sessionStart: formatFullDateTime(date: Date()),
                 sessionEnd: formatFullDateTime(date: Date()),
                 totalStudyTime: 3600, businessId: UUID())
            ],
        businessLevel: 7200,
        businessPrestige: "Growing Business"))
}

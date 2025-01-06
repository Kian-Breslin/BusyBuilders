//
//  ownerItem.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 13/11/2024.
//

import SwiftUI

struct ownerItem: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var user : UserDataModel
    var isOnline = true
    
    var body: some View {
        ZStack {
            Color.main.ignoresSafeArea()
            
            VStack {
                ZStack {
                    
                    Circle()
                        .frame(width: 150, height: 150)
                    
                    Circle()
                        .stroke(isOnline ? Color.green : getColor("red"), lineWidth: 5)
                        .frame(width: 150, height: 150)
                    
                    Image("userImage-1")
                        .resizable()
                        .frame(width: 150, height: 150)
                }
                .padding(.bottom, 30)

                VStack(alignment: .leading){
                    // Username
                    VStack (alignment: .leading){
                        Text("Username")
                            .font(.system(size: 15))
                            .opacity(0.7)
                        Text("\(user.username)")
                            .font(.system(size: 30))
                    }
                    // Name
                    VStack (alignment: .leading){
                        Text("Name")
                            .font(.system(size: 15))
                            .opacity(0.7)
                        Text("\(user.name)")
                            .font(.system(size: 30))
                    }
                    // Email
                    VStack (alignment: .leading){
                        Text("Email")
                            .font(.system(size: 15))
                            .opacity(0.7)
                        Text("\(user.email)")
                            .font(.system(size: 30))
                    }
                    // Net Worth
                    VStack (alignment: .leading){
                        Text("Net Worth")
                            .font(.system(size: 15))
                            .opacity(0.7)
                        Text("$\(user.netWorth)")
                            .font(.system(size: 30))
                    }
                    // # of Businesses
                    VStack (alignment: .leading){
                        Text("# of Businesses")
                            .font(.system(size: 15))
                            .opacity(0.7)
                        Text("\(user.businesses.count)")
                            .font(.system(size: 30))
                    }
                    // Created
                    VStack (alignment: .leading){
                        Text("Created")
                            .font(.system(size: 15))
                            .opacity(0.7)
                        Text("\(getDateMonthYear(from: user.created) ?? "")")
                            .font(.system(size: 30))
                    }
                    // Highest Streak
                    VStack (alignment: .leading){
                        Text("Highest Streak")
                            .font(.system(size: 15))
                            .opacity(0.7)
                        HStack{
                            Text("24")
                                .font(.system(size: 30))
                            Image(systemName: "flame")
                                .font(.system(size: 25))
                        }
                    }
                    // Friends
                    VStack (alignment: .leading){
                        Text("Friends")
                            .font(.system(size: 15))
                            .opacity(0.7)
                        Text("4")
                            .font(.system(size: 30))
                    }
                    // Achievements
                    VStack (alignment: .leading){
                        Text("Achievments")
                            .font(.system(size: 15))
                            .opacity(0.7)
                        Text("")
                            .font(.system(size: 30))
                    }
                    
                }
                .frame(width: screenWidth-20, alignment: .leading)
                Spacer()
            }
        }
    }
}

#Preview {
    ownerItem(user: UserDataModel(username: "Kimmy_9", name: "Kim", email: "Kim@gmail.com", password: "Clique801!", availableBalance: 100000, netWorth: 200000))
        .environmentObject(ThemeManager())
}

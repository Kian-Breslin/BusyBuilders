//
//  BottomNavigation.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 17/07/2025.
//

import SwiftUI
import SwiftData

struct BottomNavigation: View {
    @EnvironmentObject var userManager: UserManager
    @Binding var selectedIcon: String
    var body: some View {
        Rectangle()
            .frame(width: screenWidth, height: 75)
            .foregroundStyle(userManager.secondaryColor)
            .overlay {
                HStack (alignment: .top ,spacing: 15){
                    ZStack {
                        if selectedIcon == "Dashboard" {
                            Image(systemName: "square.grid.2x2.fill")
                        } else {
                            Image(systemName: "square.grid.2x2")
                        }
                        Text("Dashboard")
                            .font(.system(size: 10))
                            .offset(y:25)
                            .opacity(0)
                    }
                    .frame(width: 65, height: 60)
                    .onTapGesture {
                        selectedIcon = "Dashboard"
                    }
                    
                    ZStack {
                        if selectedIcon == "person.2" {
                            Image(systemName: "person.2.fill")
                        } else {
                            Image(systemName: "person.2")
                        }
                        Text("Social")
                            .font(.system(size: 10))
                            .offset(y: 25)
                            .opacity(0)
                    }
                    .frame(width: 65, height: 60)
                    .onTapGesture {
                        selectedIcon = "person.2"
                    }
                    ZStack {
                        if selectedIcon == "play" {
                            Image(systemName: "play.fill")
                        } else {
                            Image(systemName: "play")
                        }
                        Text("Focus")
                            .font(.system(size: 10))
                            .offset(y: 25)
                            .opacity(0)
                    }
                    .frame(width: 65, height: 60)
                    .onTapGesture {
                        selectedIcon = "play"
                    }
                    ZStack {
                        if selectedIcon == "cart" {
                            Image(systemName: "cart.fill")
                        } else {
                            Image(systemName: "cart")
                        }
                        Text("Shop")
                            .font(.system(size: 10))
                            .offset(y: 25)
                            .opacity(0)
                    }
                    .frame(width: 65, height: 60)
                    .onTapGesture {
                        selectedIcon = "cart"
                    }
                    ZStack {
                        if selectedIcon == "person" {
                            Image(systemName: "person.fill")
                        } else {
                            Image(systemName: "person")
                        }
                        Text("Profile")
                            .font(.system(size: 10))
                            .offset(y: 25)
                            .opacity(0)
                    }
                    .frame(width: 65, height: 60)
                    .onTapGesture {
                        selectedIcon = "person"
                    }
                }
                .font(.system(size: 24))
                .fontWeight(.light)
        }
        .frame(width: screenWidth, height: 75)
        .background(userManager.secondaryColor)
        .foregroundStyle(userManager.textColor)
    }
}

#Preview {
    BottomNavigation(selectedIcon: .constant("Dashboard"))
        .environmentObject(UserManager())
}

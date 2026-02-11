//
//  ContentView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 23/09/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var users: [UserDataModel]
    @EnvironmentObject var userManager: UserManager
    @State var selectedView = "Dashboard"
    var body: some View {
        ZStack {
            userManager.mainColor.ignoresSafeArea()
            
            VStack {
                if selectedView == "Dashboard" {
                    Dashboard()
                }
                else if selectedView == "person.2" {
                    Social()
                }
                else if selectedView == "play" {
                    Play()
                }
                else if selectedView == "cart" {
                    Store()
                }
                else if selectedView == "person" {
                    Portfolio()
                }
            }
            .padding(.top, 40)
            
            
            VStack {
                Spacer()
                BottomNavigation(selectedIcon: $selectedView)
            }
            .ignoresSafeArea()
        }
        .fullScreenCover(isPresented: $userManager.showSettings) {
            Settings()
        }
        .alert("Under Construction", isPresented: $userManager.underConstruction) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("This feature is not developed yet. This is a placeholder")
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(UserManager())
}


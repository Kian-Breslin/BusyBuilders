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
    
    @State var selectedView = 0
    
    var body: some View {
        if users.isEmpty {
            UserSignUp()
        }
        else {
            ZStack {
                if (selectedView == 0) {
                    Dashboard()
                } else if selectedView == 1 {
                    Communities()
                } else if selectedView == 2 {
                    StartTask()
                } else if selectedView == 3 {
                    Messages()
                } else if selectedView == 4 {
                    Portfolio()
                }
                
                VStack {
                    Spacer()
                    NavigationBar(selectedView: $selectedView)
                }
                .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [UserDataModel.self], inMemory: true)
}

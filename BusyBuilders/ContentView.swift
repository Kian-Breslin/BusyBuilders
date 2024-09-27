//
//  ContentView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 23/09/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedView = 0
    
    var imagesList = ["square.grid.2x2", "person.2", "play", "message", "person"]
    var detailsList = ["Dashboard", "Communities", "Start Task", "Messages", "Portfolio"]
    
    var body: some View {
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

#Preview {
    ContentView()
}

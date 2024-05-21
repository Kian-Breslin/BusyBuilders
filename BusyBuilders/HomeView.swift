//
//  TestView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 21/05/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                // Settings
                HStack {
                    Spacer()
                    
                    Image(systemName: "gear")
                        .foregroundStyle(.red)
                        .font(.title)
                }
                .padding(.horizontal)
                
                // User Name and Total Revenue
                HStack {
                    Image(systemName: "circle.fill")
                        .font(.largeTitle)
                    Text("Kian Breslin")
                        .font(.system(size: 24))
                    Spacer()
                    Text("$1.43M")
                        .font(.system(size: 16))
                }
                .padding()
                .padding(.vertical)
                
                ScrollView {
                    HStack {
                        SmallMainWidget()
                        Spacer()
                        SmallMainWidget()
                    }
                    .padding(.horizontal)
                    LargeMainWidget()
                        .padding(10)
                    LargeMainWidget()
                }
            }
            .padding(.vertical)
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    HomeView()
}

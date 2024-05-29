//
//  ShowBusinesses.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 28/05/2024.
//

import SwiftUI
import SwiftData

struct ShowBusinesses: View {
    
    @State var addNewBusinessSheet = false
    
    @Query var businesses : [BusinessDataModel]
    
//    var BusinessesArray : [MockBusinesses] = [
//        MockBusinesses(businessName: "Exercise Gym", businessIcon: "figure.run.circle", businessDescription: "This is the gym business which will earn money when the user works out. It will connect to Apple Health and track their workout times", businessTheme: .red),
//        MockBusinesses(businessName: "School", businessIcon: "graduationcap.circle", businessDescription: "This will track the time studied and what subject", businessTheme: .indigo),
//        MockBusinesses(businessName: "Hotel", businessIcon: "building.2.crop.circle", businessDescription: "This will use apple health to track sleep and will then show how many hours of sleep you got and turn that into money for the hotel", businessTheme: .orange)
//    ]
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.red]

    }
    
    var body: some View {
        
        if(businesses.isEmpty == false) {
            ZStack {
                
                Color.black
                    .ignoresSafeArea()
                
                NavigationStack {
                    List {
                        ForEach(businesses, id: \.businessName) { b in
                            NavigationLink(value: b){
                                HStack {
                                    Image(systemName: b.businessIcon)
                                        .font(.system(size: 40))
                                    Text("\(b.businessName)")
                                }
                                .font(.system(size: 25))
                            }
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white)
                                    .opacity(0.8)
                                    .padding(5)
                                    
                            )
                            .listRowSeparator(.hidden)
                        }
                    }
                    .navigationTitle("List Of Businesses")
                    .navigationBarTitleTextColor(.red)
                    .scrollContentBackground(.hidden)
                    .background(Color.black)
                    .foregroundStyle(.white)
                    .navigationDestination(for: BusinessDataModel.self) { b in
                        ZStack {
                            Color.black
                                .ignoresSafeArea()
                            Text("\(b.businessName)")
                                .font(.system(size: 30))
                                .foregroundStyle(.white)
                        }
                    }
                }
            }
        } else {
            ContentUnavailableView(label: {
                Label("No Businesses", systemImage: "list.bullet.rectangle.portrait")
            }, description: {
                Text("Start Adding Businesses")
            }, actions: {
                Button("Add New Business") {
                    addNewBusinessSheet = true
            }
            })
            .sheet(isPresented: $addNewBusinessSheet, content: {
                CreateBusiness()
            })
        }
        
    }
}

#Preview {
    ShowBusinesses()
}

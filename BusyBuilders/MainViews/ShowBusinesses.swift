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
    @Environment(\.modelContext) var context
    @Query var businesses : [BusinessDataModel]
    
    @State var mockBusNum = 1
    
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
                                        .font(.system(size: 30))
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
                        .onDelete(perform: { indexes in
                            for index in indexes {
                                deleteBusiness(businesses[index])
                            }
                        })
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
                            VStack (spacing: 30){
                                Text("\(b.businessName)")
                                    .font(.system(size: 30))
                                    .foregroundStyle(.white)
                                Image(systemName: "arrow.triangle.2.circlepath")
                                    .foregroundStyle(.white)
                                    .onTapGesture {
                                        updateBusiness(b)
                                }
                            }
                        }
                    }
                }
            }
        } else {
            //Add MockDate
            Button("Add Mock Data"){
                addFakeData()
                addFakeData()
                addFakeData()
                addFakeData()
                addFakeData()
                addFakeData()
            }
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
    
    func addFakeData() {
            let newFakeBusiness =
                BusinessDataModel(businessName: "Business \(mockBusNum)", businessCategory: "Category \(mockBusNum)", businessIcon: "circle", businessInvestment: "100,000", businessLevel: "20", businessRevenueAmount: "250,000", businessBadges: "7 day Streak", taskName: "Task Name \(mockBusNum)", taskDescription: "Task description should be longer than normal text", taskCategory: "Task Category \(mockBusNum)", taskGoal: "Finish App Developement", taskDeadline: Date(), taskStartDate: Date())

            context.insert(newFakeBusiness)
            mockBusNum += 1
        }

    
    func deleteBusiness(_ business: BusinessDataModel) {
        context.delete(business)
    }
    
    func updateBusiness(_ business: BusinessDataModel) {
        // Edit the item
        business.businessName = "Updated Business Name"
        // Save the changes
        try? context.save()
    }
}

#Preview {
    ShowBusinesses()
        .modelContainer(for: [BusinessDataModel.self, UserDataModel.self], inMemory: true)
}

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
                                Text("$\(b.businessRevenueAmount)")
                                Image(systemName: "arrow.triangle.2.circlepath")
                                    .onTapGesture {
                                        updateBusiness(b, "100,000")
                                }
                            }
                            .foregroundStyle(.white)
                            .font(.system(size: 30))
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
                BusinessDataModel(businessName: "Business \(mockBusNum)", businessCategory: "Category \(mockBusNum)", businessIcon: "circle", businessInvestment: "145,000", businessLevel: "20", businessRevenueAmount: "\((50000)+10000*mockBusNum)", businessBadges: "7 day Streak", taskName: "Task Name \(mockBusNum)", taskDescription: "Task description should be longer than normal text", taskCategory: "Task Category \(mockBusNum)", taskGoal: "Finish App Developement", taskDeadline: Date(), taskStartDate: Date())

            context.insert(newFakeBusiness)
            mockBusNum += 1
        }

    
    func deleteBusiness(_ business: BusinessDataModel) {
        context.delete(business)
    }
    
    public func updateBusiness(_ business: BusinessDataModel, _ amountChange: String) {
        // Edit the item
        business.businessName = "New Business Name"
        business.businessRevenueAmount = amountChange
        // Save the changes
        try? context.save()
    }
}

#Preview {
    ShowBusinesses()
        .modelContainer(for: [BusinessDataModel.self, UserDataModel.self], inMemory: true)
}

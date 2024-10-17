//
//  Portfolio.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 23/09/2024.
//

import SwiftUI
import SwiftData

struct Portfolio: View {
    
    @AppStorage("userColorPreference") var userColorPreference: String = "red"
    @Environment(\.modelContext) var context
    @Query var users: [UserDataModel]
    @Query var businesses: [BusinessDataModel] // Query for businesses
    
    @State var isNewBusinessSheetShowing = false
    
    // For Developement
    let devNames = ["Math Masters","Eco Innovators","Science Solutions","Code Creators","Design Depot","Robotics Realm","Tech Repair Hub","Game Forge","AI Insights","Physics Powerhouse"]

    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                VStack {
                    Button("Create Mock Business for testing") {
                        let newBusiness = BusinessDataModel(businessName: "\(devNames[Int.random(in: 0..<10)])", businessTheme: "Red", businessType: "Eco Friendly", businessIcon: "Circle", cashPerMin: 1000)
                        
                        context.insert(newBusiness)
                        
                        do {
                            try context.save()
                        } catch {
                            print("Failed to save new business: \(error)")
                        }
                    }
                    .frame(width: 300, height: 50)
                    .background(colorForName(userColorPreference))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    
                    Button("Create Actual Business"){
                        isNewBusinessSheetShowing = true
                    }
                    .frame(width: 300, height: 50)
                    .background(colorForName(userColorPreference))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(.white)
                    .fontWeight(.bold)

                    // List existing businesses
                    List {
                        ForEach(businesses) { business in
                            NavigationLink(destination: BusinessDetails(business: business)) {
                                HStack {
                                    Text(business.businessName)
                                        .font(.headline)
                                }
                                .padding()
                            }
                        }
                        .onDelete(perform: deleteBusiness) // Add onDelete to the ForEach
                    }
                }
                .padding()
            }
            .navigationTitle("Portfolio") // Set the title for the navigation view
        }
        .sheet(isPresented: $isNewBusinessSheetShowing) {
            CreateNewBusiness()
                .presentationDetents([.fraction(0.8)])
        }
    }
    func deleteBusiness(at offsets: IndexSet) {
        for index in offsets {
            let business = businesses[index]
            context.delete(business) // Remove from the context
        }

        // Make sure to save the context after deletion
        try? context.save()
    }
}

// A new view to display the details of the selected business
struct BusinessDetailView: View {
    var business: BusinessDataModel

    var body: some View {
        VStack {
            Text(business.businessName)
                .font(.largeTitle)
                .padding()
            
            

            Spacer()
        }
        .navigationTitle("Business Details") // Title for the detail view
        .navigationBarTitleDisplayMode(.inline) // Optional: display title inline
    }
}

#Preview {
    Portfolio()
        .modelContainer(for: UserDataModel.self, inMemory: true)
}

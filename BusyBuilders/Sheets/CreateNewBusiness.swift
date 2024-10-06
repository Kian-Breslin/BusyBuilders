//
//  CreateNewBusiness.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 05/10/2024.
//

import SwiftUI
import SwiftData

struct CreateNewBusiness: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @Query var users: [UserDataModel]
    @Query var businesses: [BusinessDataModel] // Query for businesses
    
    @State var businessName = ""
    @State var businessTheme = ""
    @State var businessIcon = ""
    @State var businessType = ""
    @State var owners = ""
    @State var investment = 0
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                VStack {
                    Text("Current Capital")
                        .font(.system(size: 30))
                    Text("$3,405,500")
                        .font(.system(size: 50))
                }
                
                // Business Name
                TextField("Enter Business Name", text: $businessName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // Business Theme
                TextField("Enter Business Theme", text: $businessTheme)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // Business Icon
                TextField("Enter Business Icon", text: $businessIcon)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // Business Type
                TextField("Enter Business Type", text: $businessType)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // Owners
                TextField("Invite Owners (comma separated)", text: $owners)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // Investment
                TextField("Amount", value: $investment, formatter: NumberFormatter())
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Create!"){
                    let newBusiness = BusinessDataModel(businessName: businessName, businessTheme: businessTheme, businessType: businessType, businessIcon: businessIcon, investment: investment)
                    
                    context.insert(newBusiness)
                    
                    do {
                        try context.save()
                    } catch {
                        print("Failed to save new business: \(error)")
                    }
                    dismiss()
                }
                .frame(width: 300, height: 50)
                .background(Color(red: 244/255, green: 73/255, blue: 73/255))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundStyle(.white)
                .fontWeight(.bold)
            }
            .frame(width: screenWidth-30, alignment: .leading)
        }
    }
}

#Preview {
    CreateNewBusiness()
        .modelContainer(for: [UserDataModel.self, BusinessDataModel.self], inMemory: true)
}

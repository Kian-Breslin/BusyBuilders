//
//  CreateNewBusiness.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 05/10/2024.
//

import SwiftUI
import SwiftData

struct CreateNewBusiness: View {
    
    @AppStorage("userColorPreference") var userColorPreference: String = "red"
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
    @State var choseColor : [Color] = [Color.red, Color.blue, Color.green, Color.yellow, Color.pink, Color.purple]
    let colorNames: [String] = ["red", "blue", "green", "yellow", "pink", "purple"]
    @State var selectedColor : String = "red"
    
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
                VStack (alignment: .leading){
                    Text("Enter your Business Name")
                        .font(.system(size: 10))
                    TextField("e.g The Coffee Shop", text: $businessName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                // Business Icon
                VStack (alignment: .leading){
                    Text("Chose your Building")
                        .font(.system(size: 10))
                    TextField("e.g Triangle", text: $businessIcon)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                // Business Type
                VStack (alignment: .leading){
                    Text("Enter your Business Type")
                        .font(.system(size: 10))
                    TextField("e.g Eco Friendly", text: $businessType)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                // Investment
                VStack (alignment: .leading){
                    Text("Investment")
                        .font(.system(size: 10))
                    TextField("$0", value: $investment, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                }
                
                // Business Theme
                VStack (alignment: .leading){
                    Text("Business Theme")
                        .font(.system(size: 10))
                    Picker("Select a Color", selection: $businessTheme) {
                        ForEach(0..<5){ c in
                            Text("\(colorNames[c])").tag(colorNames[c])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 300, height: 5)
                    .foregroundStyle(getColor(businessTheme))
                
                HStack {
                    Text("Add Business Partners")
                    Spacer()
                    Image(systemName: "qrcode")
                        .font(.system(size: 25))
                }
                .padding(.trailing)
                .padding(.leading, 5)
                .padding(.bottom, 15)

                Button("Create"){
                    let newBusiness = BusinessDataModel(businessName: businessName, businessTheme: businessTheme, businessType: businessType, businessIcon: businessIcon, investment: investment)
                    
                    context.insert(newBusiness)
                    
                    do {
                        try context.save()
                    } catch {
                        print("Failed to save new business: \(error)")
                    }
                    dismiss()
                }
                .frame(width: 150, height: 50)
//                .background(getColor(userColorPreference))
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

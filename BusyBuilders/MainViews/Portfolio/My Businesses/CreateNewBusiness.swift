//
//  CreateNewBusiness.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 05/10/2024.
//

import SwiftUI
import SwiftData

struct CreateNewBusiness: View {
    
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @Query var users: [UserDataModel]
    @Query var businesses: [BusinessDataModel] // Query for businesses
    
    @FocusState var isTextFieldFocused : Bool
    @State var businessName = ""
    @State var businessTheme = ""
    @State var businessIcon = ""
    @State var businessType = ""
    @State var owners = ""
    @State var ownersArray : [UserDataModel] = []
    @State var investments = 0.0
    @State var choseColor : [Color] = [Color.red, Color.blue, Color.green, Color.yellow, Color.pink, Color.purple]
    let businessTypeNames = ["Eco-Friendly", "Corporate", "Innovative"]
    let colorNames: [String] = ["Red", "Blue", "Green", "Yellow", "Pink", "Purple"]
    let iconNames: [String] = ["triangle", "diamond", "pentagon", "shield", "rhombus"]
    @State var selectedColor : String = "red"
    
    var body: some View {
        ZStack {
            themeManager.mainColor
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 10) {
                VStack (alignment: .leading){
                    Text("Current Capital")
                        .font(.system(size: 20))
                    Text("$\(users.first?.availableBalance ?? 0)")
                        .font(.system(size: 40))
                }
                
                // Business Name
                VStack (alignment: .leading){
                    Text("Enter your Business Name")
                        .font(.system(size: 12))
                    TextField("e.g The Coffee Shop", text: $businessName)
                        .foregroundStyle(themeManager.mainColor)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .focused($isTextFieldFocused)
                        .onTapGesture {
                            // Use this gesture to dismiss the keyboard if it's focused
                            isTextFieldFocused = false
                        }
                }
                
                // Investment
                VStack(alignment: .leading) {
                    Text("Investment: $\(investments, specifier: "%.f")")
                        .font(.system(size: 12))

                    // Ensure availableBalance is not negative or zero
                    if let availableBalance = users.first?.availableBalance, availableBalance > 0 {
                        // Only show the slider if the available balance is positive
                        Slider(value: $investments, in: 0...Double(availableBalance), step: 500)
                    } else {
                        Text("Your available balance is too low")
                            .font(.system(size: 15))
                            .foregroundColor(.red)
                    }
                }
                
                // Business Icon
                VStack (alignment: .leading){
                    Text("Chose your Icon")
                        .font(.system(size: 12))
                    Picker("Select a Business Icon", selection: $businessIcon) {
                        ForEach(0..<5){ c in
                            Image(systemName: "\(iconNames[c])").tag(iconNames[c])
                                .foregroundStyle(themeManager.textColor)
                        }
                        .foregroundStyle(themeManager.textColor)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                // Business Type
                VStack (alignment: .leading){
                    Text("Chose your Business Type")
                        .font(.system(size: 12))
                    Picker("Select a Business Type", selection: $businessType) {
                        ForEach(0..<3){ c in
                            Text("\(businessTypeNames[c])").tag(businessTypeNames[c])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                // Business Theme
                VStack (alignment: .leading){
                    Text("Business Theme")
                        .font(.system(size: 12))
                    Picker("Select a Color", selection: $businessTheme) {
                        ForEach(0..<5){ c in
                            Text("\(colorNames[c])").tag(colorNames[c])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: screenWidth-20, height: 5)
                    .foregroundStyle(getColor(businessTheme))
                
                VStack (alignment: .leading){
                    Text("Add Owner")
                        .font(.system(size: 12))
                    HStack {
                        TextField("Username", text: $owners)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Image(systemName: owners == "" ? "qrcode" : "plus")
                            .font(.system(size: 25))
                            .onTapGesture {
                                if owners != "" {
                                    ownersArray.append(createUserFromUsername(owners))
                                    print(ownersArray)
                                }
                                owners = ""
                            }
                    }
                }
                
                
                HStack {
                    Spacer()
                    Button("Create") {
                        guard let user = users.first else {
                            print("No user found!")
                            return
                        }

                        let investment = Int(investments)
                        let newBusiness = BusinessDataModel(
                            businessName: businessName,
                            businessTheme: businessTheme,
                            businessType: businessType,
                            businessIcon: businessIcon,
                            investment: investment
                        )

                        
                        var allOwners = [user]
                        allOwners.append(contentsOf: ownersArray)

                        // Insert all owners into the new business
                        newBusiness.Owners.insert(contentsOf: allOwners, at: 0)

                        // Save the new business to the context
                        user.businesses.insert(newBusiness, at: 0)

                        do {
                            try context.save()
                        } catch {
                            print("Failed to save new business: \(error)")
                        }

                        dismiss()
                    }
                    .frame(width: 150, height: 40)
                    .background(themeManager.textColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .disabled(businessName.isEmpty || businessType.isEmpty)
                    .foregroundStyle(themeManager.mainColor.opacity(businessName.isEmpty || businessType.isEmpty ? 0.5 : 1))
                    .fontWeight(.bold)
                    Spacer()
                }            }
            .frame(width: screenWidth-20, alignment: .leading)
        }
        .foregroundStyle(themeManager.textColor)
    }
}

#Preview {
    CreateNewBusiness()
        .modelContainer(for: [UserDataModel.self, BusinessDataModel.self], inMemory: true)
        .environmentObject(ThemeManager())
}

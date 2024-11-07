//
//  Test View.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 07/11/2024.
//

import SwiftUI

struct Test_View: View {
    @State private var businessName: String = ""
    @State private var investment: Double = 0.0
    @State private var businessType: String = "Corporate"
    @State private var isConfirmed: Bool = false

    let businessTypes = ["Eco-Friendly", "Corporate", "Innovative"]

    var body: some View {
        Form {
            Section(header: Text("Business Details")) {
                TextField("Business Name", text: $businessName)
                
                Picker("Business Type", selection: $businessType) {
                    ForEach(businessTypes, id: \.self) {
                        Text($0)
                    }
                }
            }

            Section(header: Text("Investment")) {
                Slider(value: $investment, in: 0...100000, step: 500)
                Text("Investment: \(Int(investment))")
            }
            
            Section {
                Toggle("Confirm Details", isOn: $isConfirmed)
            }

            Button("Create Business") {
                // Action to create the business
            }
            .disabled(!isConfirmed) // Disable until confirmed
        }
        .navigationTitle("New Business")
    }
}

#Preview {
    Test_View()
}

//
//  DashboardTopButtons.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 08/10/2024.
//

import SwiftUI
import SwiftData

struct DashboardTopButtons: View {
    
    @Environment(\.modelContext) var context
    @Query var users: [UserDataModel]
    @Query var businesses: [BusinessDataModel] // Query for businesses
    
    @Binding var title : String
    @Binding var totalNetWorth : Double
    @State var userColor : Color
    @State var selectedBusiness : BusinessDataModel?
    @State var shakeAnimation = false
    
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            if title == "Withdraw Money"{
                VStack {
                    Text("\(title)")
                        .font(.system(size: 30))
                        .foregroundStyle(.black)
                    
                    Text("Available Balance: $\(users.first?.availableBalance ?? 0)")
                        .font(.system(size: 20))
                        .foregroundStyle(.black)
                    
                    Spacer()
                    
                    Text("\(selectedBusiness?.businessName ?? "Selected Business")'s NetWorth: $\(selectedBusiness?.netWorth ?? 0, specifier: "%.f")")
                        .foregroundStyle(.black)
                    
                    Menu {
                        Picker("Select Business", selection: $selectedBusiness) {
                            ForEach(businesses, id: \.id) { business in
                                Text(business.businessName).tag(business as BusinessDataModel?)
                            }
                        }
                    } label: {
                        HStack {
                            Text("Select Business: \(selectedBusiness?.businessName ?? "None")")
                                .foregroundColor(userColor)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(8)
                                .shadow(radius: 5)
                        }
                    }
                    .padding(40)
                    
                    Button("Withdraw $500") {
                        if let selectedBusiness = selectedBusiness {
                            if selectedBusiness.netWorth >= 500 {
                                selectedBusiness.netWorth -= 500
                                users.first?.availableBalance += 500
                                
                                // Manually update the total net worth
                                totalNetWorth = businesses.reduce(0) { $0 + $1.netWorth } + Double(users.first?.availableBalance ?? 0)
                                
                                do {
                                    try context.save()
                                } catch {
                                    print("Failed to save new business: \(error)")
                                }
                            }
                            else {
                                withAnimation(Animation.linear(duration: 0.05).repeatCount(6, autoreverses: true)) {
                                    shakeAnimation = true
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    shakeAnimation = false // Reset shake state after animation
                                }
                            }
                        }
                    }
                    .foregroundStyle(.red)
                    .offset(x: shakeAnimation ? -10 : 0)
                    
                    Button("Add Quick $500") {
                        selectedBusiness?.netWorth += 500
                    }
                    .foregroundStyle(.red)
                    
                    Spacer()
                }
            }
            else {
                VStack {
                    Text("\(title)")
                        .font(.system(size: 40))
                    
                    Spacer()
                    
                    Text("This is a placeholder for the sheet view when you click : " + "\(title)")
                        .foregroundStyle(.black)
                    
                    Spacer()
                }
            }
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    DashboardTopButtons(title: .constant("Withdraw Money"), totalNetWorth: .constant(20000.0), userColor: Color.red)
}

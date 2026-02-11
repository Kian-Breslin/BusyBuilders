//
//  HiringDeptView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 22/07/2025.
//
import SwiftUI
import SwiftData

struct HiringDeptView: View {
    @Query var users: [UserDataModel]
    let business : BusinessDataModel
    var body: some View {
        VStack (alignment: .leading){
            
            HStack {
                VStack (alignment: .leading){
                    Label("Level: \(business.departments["Hiring Department"]?.level ?? 0) / 30", systemImage: "star.fill")
                    Label("$5,000", systemImage: "chevron.up")
                        .foregroundStyle(.green)
                }
                Spacer()
                customButton(text: "Upgrade", color: getColor(business.businessTheme), width: 150, height: 50, action: {
                    if let user = users.first {
                        if user.availableBalance >= 5000 {
                            user.availableBalance -= 5000
                            business.upgradeDepartment(dept: "Hiring Department")
                        }
                    }
                })
                
                
                
            }
            .padding(.top, 10)
            HStack {
                VStack (alignment: .leading){
                    Label("Employees: \(business.employees)", systemImage: "person.3")
                    Label("Boost: $\(business.employeeCashperMinute)", systemImage: "plus.square")
                        .foregroundStyle(.green)
                    Label("Wages: $\(business.employeeCostperMinute)", systemImage: "minus.square")
                        .foregroundStyle(.red)
                    Label("Hire: $\(business.hiringCost)", systemImage: "banknote")
                }
                Spacer()
                customButton(text: "Hire", color: getColor(business.businessTheme), width: 150, height: 50, action: {
                    if let user = users.first {
                        if user.availableBalance >= business.hiringCost {
                            user.availableBalance -= business.hiringCost
                            business.addEmployee()
                        }
                    }
                })
                
            }

            Spacer()
        }
        .frame(width: screenWidth-40, height: 200, alignment: .leading)
        .padding(.top, 10)
    }
}

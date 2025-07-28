//
//  ResearchDeptView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 22/07/2025.
//
import SwiftUI
import SwiftData


struct ResearchDeptView: View {
    @Query var users: [UserDataModel]
    let business: BusinessDataModel
    @Binding var showProductLaunchScreen: Bool
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Label("Level: \(business.departments["Research and Development Department"]?.level ?? 0) / 30", systemImage: "star.fill")
                    Label("$5,000", systemImage: "chevron.up")
                        .foregroundStyle(.green)
                }
                Spacer()
                customButton(text: "Upgrade", color: getColor(business.businessTheme), width: 150, height: 50, action: {
                    if let user = users.first, user.availableBalance >= 5000 {
                        user.availableBalance -= 5000
                        business.upgradeDepartment(dept: "Research and Development Department")
                    }
                })
            }
            .padding(.top, 10)
            HStack {
                VStack(alignment: .leading) {
                    Label("R&D Efficiency: High", systemImage: "flame")
                }
                Spacer()
                customButton(text: "Research", color: getColor(business.businessTheme), width: 150, height: 50, action: {})
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Label("Products Launched: 3", systemImage: "cube.box")
                }
                Spacer()
                customButton(text: "Lauch", color: getColor(business.businessTheme), width: 150, height: 50, action: {
                    showProductLaunchScreen.toggle()
                })
            }
            Spacer()
        }
        .frame(width: screenWidth-40, height: 200, alignment: .leading)
        .padding(.top, 10)
    }
}

#Preview {
    ResearchDeptView(business: BusinessDataModel.previewBusiness, showProductLaunchScreen: .constant(false))
        .background(UserManager().secondaryColor)
        .environmentObject(UserManager())
}

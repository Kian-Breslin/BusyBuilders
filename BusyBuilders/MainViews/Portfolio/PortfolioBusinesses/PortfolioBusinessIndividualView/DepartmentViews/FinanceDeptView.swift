//
//  FinanceDeptView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 22/07/2025.
//
import SwiftUI
import SwiftData

struct FinanceDeptView: View {
    @Query var users: [UserDataModel]
    let business : BusinessDataModel
    var body: some View {
        VStack (alignment: .leading){
            Text("Current Level: \(business.departments["Finance Department"]?.level ?? 0)")
                
            Spacer()
        }
        .frame(width: screenWidth-20, height: 150, alignment: .leading)
        .padding(.top, 10)
    }
}

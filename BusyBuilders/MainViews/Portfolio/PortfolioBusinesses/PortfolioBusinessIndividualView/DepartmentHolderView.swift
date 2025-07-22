//
//  DepartmentView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 22/07/2025.
//
import SwiftUI
import SwiftData

struct DepartmentHolderView: View {
    @EnvironmentObject var userManager: UserManager
    @Query var users : [UserDataModel]
    let business : BusinessDataModel
    @State var selectedDepartment = "Owned"
    
    var body: some View {
        ZStack {
            userManager.mainColor.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Departments")
                    .font(.headline)
                    .foregroundColor(userManager.textColor)

                VStack {
                    ForEach(business.departments.sorted(by: { $0.key < $1.key }), id: \.key) { dept, info in
                        DepartmentItem(user: users.first, selectedDept: $selectedDepartment, dept: dept, business: business)
                            .onTapGesture {
                                withAnimation(.snappy){
                                    if ((business.departments[dept]?.isUnlocked) != nil){
                                        selectedDepartment = dept
                                    }
                                }
                            }
                    }
                }
                
            }
        }
    }
}

#Preview {
    DepartmentHolderView(business: BusinessDataModel.previewBusiness)
        .environmentObject(UserManager())
}

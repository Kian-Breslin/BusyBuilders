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
    @Binding var showDepartments: Bool
    
    var body: some View {
        ZStack {
            userManager.mainColor.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Departments")
                        
                    Spacer()
                    
                    Group{
                        Text("\(showDepartments ? "Hide" : "Show")")
                            .font(.caption)
                        Image(systemName: "\(showDepartments ? "chevron.down" : "chevron.right")")
                            .font(.caption)
                    }
                    .onTapGesture {
                        withAnimation(.snappy(duration: 0.3)){
                            showDepartments.toggle()
                        }
                    }
                }
                .frame(width: screenWidth-20)
                .font(.headline)
                .foregroundColor(userManager.textColor)

                if showDepartments {
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
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                
            }
        }
    }
}

#Preview {
    DepartmentHolderView(business: BusinessDataModel.previewBusiness, showDepartments: .constant(false))
        .environmentObject(UserManager())
}

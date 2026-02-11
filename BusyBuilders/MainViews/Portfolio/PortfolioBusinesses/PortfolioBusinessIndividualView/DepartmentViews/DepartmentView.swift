//
//  DepartmentView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 21/07/2025.
//

import SwiftUI
import SwiftData

struct DepartmentView: View {
    @EnvironmentObject var userManager: UserManager
    let business : BusinessDataModel
    let department: String
    
    @State var showInfo = false
    var body: some View {
        ZStack {
            userManager.mainColor.ignoresSafeArea()
            
            VStack (alignment: .leading){
                HStack {
                    Text("\(business.businessName) - \(department)")
                    Spacer()
                    Image(systemName: "info.circle")
                        .onTapGesture {
                            showInfo.toggle()
                        }
                }
                .font(.title2)
                
                Label("2", systemImage: "star.fill")
                Label("$25,000", systemImage: "banknote.fill")
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(getColor(business.businessTheme), lineWidth: 2)
                    .frame(width: screenWidth-20, height: 50)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(getColor(business.businessTheme).opacity(0.3))
                            .overlay {
                                HStack {
                                    Text("Upgrade")
                                    Spacer()
                                    Text("$30,000")
                                    Image(systemName: "plus.square")
                                        .font(.title)
                                }
                                .font(.title3)
                                .padding(.horizontal, 10)
                            }
                    }
            }
            .foregroundStyle(userManager.textColor)
            .frame(width: screenWidth-20, alignment: .leading)
        }
        .alert("\(department)", isPresented: $showInfo) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("This is the description of the department - get from function")
        }
    }
}

#Preview {
    DepartmentView(business: BusinessDataModel.previewBusiness, department: "Hiring Department")
        .environmentObject(UserManager())
}

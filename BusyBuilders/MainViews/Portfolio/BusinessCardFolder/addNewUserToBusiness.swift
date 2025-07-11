//
//  addNewUserToBusiness.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 06/11/2024.
//

import SwiftUI

struct addNewUserToBusiness: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @Binding var newUser : String
    @Binding var isOwner : Bool
    @Binding var isAddNewUserFromEdit : Bool
    @Binding var business : BusinessDataModel
    
    var body: some View {
        HStack {
            TextField("New User",text: $newUser)
                .font(.system(size: 25))
                .textFieldStyle(.roundedBorder)
            
            Image(systemName: "\(newUser == "" ? "qrcode" : "plus")")
                .font(.system(size: 30))
                .onTapGesture {
                    if newUser == "" {
                        print("User clicked QR Code")
                    } else {
                        isOwner ? print("User added \(newUser) to Owners") : print("User added \(newUser) to Investors")
                        
                        if isOwner == true {
                            business.Owners.append(UserDataModel(username: newUser, name: newUser, email: "\(newUser)@gmail.com"))
                        } else {
                            business.investors.append(UserDataModel(username: newUser, name: newUser, email: "\(newUser)@gmail.com"))
                        }
                    }
                    newUser = ""
                    isAddNewUserFromEdit.toggle()
                }
        }
    }
}

#Preview {
    addNewUserToBusiness(newUser: .constant("Kian"), isOwner: .constant(true), isAddNewUserFromEdit: .constant(true), business: .constant(BusinessDataModel(
        businessName: "Kians Shop",
        businessTheme: "Blue",
        businessType: "Economic",
        businessIcon: "triangle",
        owners: [UserDataModel(username: "Kian_17", name: "Kian", email: "Kianbreslin@gmail.com")],
        netWorth: 6000,
        investors: [],
        badges: ["10 Days Streak", "$1000 Earned", "First Upgrade"],
        sessionHistory:
            [SessionDataModel(
                id: UUID(),
                sessionDate: Date.now,
                sessionStart: formatFullDateTime(date: Date()),
                sessionEnd: formatFullDateTime(date: Date()),
                businessId: UUID(), totalStudyTime: 3600),
             SessionDataModel(
                 id: UUID(),
                 sessionDate: Date.now,
                 sessionStart: formatFullDateTime(date: Date()),
                 sessionEnd: formatFullDateTime(date: Date()),
                 businessId: UUID(), totalStudyTime: 3600)
            ],
        businessPrestige: "Growing Business")))
    .environmentObject(ThemeManager())
}

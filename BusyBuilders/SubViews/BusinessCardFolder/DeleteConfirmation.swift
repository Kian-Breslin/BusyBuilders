//
//  DeleteConfirmation.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 04/11/2024.
//

import SwiftUI
import SwiftData

struct DeleteConfirmation: View {
    
    @Query var businesses: [BusinessDataModel]
    
    @Binding var Business : BusinessDataModel
    @Binding var deletingUserIndex : Int
    @Binding var user : String
    @Binding var confirm : Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
        .frame(width: 250, height: 130)
        .overlay {
            VStack (spacing: 5){
                Text("Confirm Delete")
                    .font(.system(size: 20))
                    .bold()
                    .padding(.top, 5)

                VStack (spacing: 5){
                    Text("\(user) will be deleted")
                    Text("This action cannot be undone")
                }
                .font(.system(size: 15))
            
                Divider()
                
                HStack {
                    Text("Delete")
                        .font(.system(size: 20))
                        .frame(width: 75)
                        .onTapGesture {
                            Business.investors.remove(at: deletingUserIndex)
                            confirm = false
                        }
                    Divider()
                        .padding(.horizontal, 20)
                    Text("Back")
                        .font(.system(size: 20))
                        .frame(width: 75)
                        .onTapGesture {
                            confirm = false
                        }
                }
                .foregroundStyle(.blue)
                .frame(height: 40)
            }
            .foregroundStyle(getColor("black"))
        }
    }
}

#Preview {
    DeleteConfirmation(Business: (.constant(BusinessDataModel(
        businessName: "Kians Shop",
        businessTheme: "Blue",
        businessType: "Economic",
        businessIcon: "triangle",
        owners: [UserDataModel(username: "Kian_17", name: "Kian", email: "Kianbreslin@gmail.com")],
        cashPerMin: 3000,
        netWorth: 6000,
        investors: [
            UserDataModel(username: "Kimberly_01", name: "Kim", email: "KimberlyLeon@gmail.com"),
            UserDataModel(username: "Jack_00", name: "Kim", email: "KimberlyLeon@gmail.com"),
            UserDataModel(username: "Jay_09", name: "Kim", email: "KimberlyLeon@gmail.com")
        ],
        badges: ["10 Days Streak", "$1000 Earned", "First Upgrade", "", "", "", "", "", "", "",],
        sessionHistory:
            [SessionDataModel(
                id: UUID(),
                sessionDate: Date.now,
                sessionStart: formatFullDateTime(date: Date()),
                sessionEnd: formatFullDateTime(date: Date()),
                totalStudyTime: 3600, businessId: UUID()),
             SessionDataModel(
                 id: UUID(),
                 sessionDate: Date.now,
                 sessionStart: formatFullDateTime(date: Date()),
                 sessionEnd: formatFullDateTime(date: Date()),
                 totalStudyTime: 3600, businessId: UUID())
            ],
        businessLevel: 7200,
        businessPrestige: "Growing Business")
)), deletingUserIndex: .constant(0)
, user: .constant("Kian_17"), confirm: .constant(true))
}

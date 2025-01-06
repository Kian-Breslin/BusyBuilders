//
//  BankTransferView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 22/11/2024.
//

import SwiftUI

struct BankTransferView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @State var selectedUser : String = "Kim_01"
    let fakeUsers = ["Kian_17","Timmy_09", "Kim_01", "CoOp", "Bob", "Johnny", "33Mary", "Sarah_99"]
    var body: some View {
        ZStack {
            themeManager.mainColor
                .ignoresSafeArea()
            
            VStack (alignment:.leading, spacing: 50){
                Text("Transfer")
                    .font(.title)
                    .frame(width: screenWidth-20, alignment: .leading)
                
                
                Menu {
                    Picker("User: ", selection: $selectedUser) {
                        ForEach(fakeUsers, id: \.self) { user in
                            Text(user)
                                .tag(user)
                        }
                    }
                }
                label: {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(themeManager.textColor)
                        .frame(width: screenWidth-20, height: 50)
                        .overlay {
                            HStack {
                                Text("Select User :")
                                Spacer()
                                Text(selectedUser)
                                Image(systemName: "chevron.up.chevron.down")
                                    .font(.headline)
                            }
                            .foregroundStyle(themeManager.mainColor)
                            .padding(.horizontal)
                            .font(.title3)
                        }
                }
                
                VStack (alignment:.leading){
                    Text(selectedUser)
                        .font(.title)
                        .bold()
                    
                    VStack {
                        HStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: (screenWidth-35)/2, height: 80)
                            
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: (screenWidth-35)/2, height: 80)
                        }
                    }
                }
                .font(.title3)
                Spacer()
                
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: (screenWidth-35)/2, height: 50)
                        .overlay {
                            Text("Send")
                                .foregroundStyle(themeManager.mainColor)
                                .font(.title)
                        }
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: (screenWidth-35)/2, height: 50)
                        .overlay {
                            Text("Request")
                                .foregroundStyle(themeManager.mainColor)
                                .font(.title)
                        }
                }
                .padding(.bottom, 50)
            }
        }
        .foregroundStyle(themeManager.textColor)
    }
}

#Preview {
    BankTransferView()
        .environmentObject(ThemeManager())
}

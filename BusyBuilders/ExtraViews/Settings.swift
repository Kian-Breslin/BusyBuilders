//
//  Settings.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 19/07/2025.
//

import SwiftUI
import SwiftData

struct Settings: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userManager: UserManager
    @Query var users : [UserDataModel]
    
    // Admin Settings -> Delete on release
    @State var editBusiness = false
    
    var body: some View {
        ZStack {
            userManager.mainColor.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    
                    Label("Back", systemImage: "chevron.left")
                        .foregroundStyle(getColor(userManager.accentColor))
                        .onTapGesture {
                            dismiss()
                        }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Account")
                            .font(.caption)
                        if let user = users.first {
                            Text("Username: \(user.username)")
                            Text("Email: \(user.email)")
                            
                        }
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Dark Mode")
                            .font(.caption)
                        DayNighCycle(isDay: $userManager.isDarkMode)
                    }
                    
                    ThemePickerView(theme: $userManager.accentColor)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Notifications")
                            .font(.caption)
                        Toggle("Enable Reminders", isOn: .constant(true)) // Bind to real setting
                        Toggle("Session Alerts", isOn: .constant(true))
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("App Info")
                            .font(.caption)
                        HStack {
                            Text("Version")
                            Spacer()
                            Text("1.0.0")
                                .foregroundStyle(.gray)
                        }
                        Button("Privacy Policy") {
                            // Open link or navigate
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Admin Settings")
                            .font(.caption)
                        HStack {
                            Text("Increase Available Balance")
                            Spacer()
                            Image(systemName: "plus.square")
                                .onTapGesture {
                                    if let user = users.first {
                                        user.availableBalance += 10000
                                    }
                                }
                        }
                        HStack {
                            Text("Reset Account: \(users.count)")
                            Spacer()
                            Image(systemName: "arrow.trianglehead.counterclockwise")
                                .onTapGesture {
                                    userManager.isUserCreated = false
                                    if let user = users.first {
                                        context.delete(user)
                                    }
                                }
                        }
                        HStack {
                            Text("Delete All Businesses")
                            Spacer()
                            Image(systemName: "trash.fill")
                        }
                        HStack {
                            Text("Edit Business")
                            Spacer()
                            Image(systemName: "arrow.right")
                                .rotationEffect(.degrees(editBusiness ? 90 : 0))
                                .onTapGesture {
                                    withAnimation(.linear){
                                        editBusiness.toggle()
                                    }
                                }
                        }
                        if editBusiness {
                            ScrollView(.horizontal) {
                                HStack {
                                    if let user = users.first {
                                        ForEach(user.businesses ?? []) { business in
                                            editBusinessItem(business: business)
                                                .padding(5)
                                        }
                                    }
                                }
                            }
                            .transition(.slide)
                        }
                    }
                }
                .padding(2)
                .foregroundStyle(userManager.textColor)
                .frame(width: screenWidth-20, alignment: .leading)
            }
        }
    }
}

struct DayNighCycle: View {
    @Binding var isDay : Bool
    var body: some View {
        ZStack {
            Image(systemName: "sun.max.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundStyle(.black)
                .offset(x: isDay ? -100 : 0, y: isDay ? 50 : 0)
            
            Image(systemName: "moon.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundStyle(.white)
                .offset(x: isDay ? 0 : 100, y: isDay ? 0 : 50)
        }
        .animation(.bouncy, value: isDay)
        .clipShape(Circle())
        .frame(width: 50, height: 50)
        .onTapGesture {
            isDay.toggle()
        }
    }
}

struct editBusinessItem: View {
    @EnvironmentObject var userManager: UserManager
    let business : BusinessDataModel
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(getColor(business.businessTheme).opacity(0.3))
            .frame(width: 180, height: 100)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(userManager.textColor, lineWidth: 2)
                    .overlay {
                        VStack (alignment: .leading){
                            HStack {
                                Text("\(business.businessName)")
                                Image(systemName: "\(business.businessIcon)")
                            }
                            HStack {
                                Label("$\(business.cashPerMinute)", systemImage: "banknote.fill")
                                    .font(.caption)
                                
                                Label("$\(business.costPerMinute)", systemImage: "minus.square.fill")
                                    .font(.caption)
                                Label("\(business.level)", systemImage: "star.fill")
                                    .font(.caption)
                            }
                            Label("$\(business.netWorth)", systemImage: "dollarsign.bank.building.fill")
                                .font(.caption)
                            
                            HStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: 70, height: 20)
                                    .overlay {
                                        Text("Level +")
                                            .foregroundStyle(userManager.textColor)
                                            .font(.caption2)
                                    }
                                    .onTapGesture {
                                        business.totalTime += 60
                                    }
                                
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: 70, height: 20)
                                    .overlay {
                                        Text("Level -")
                                            .foregroundStyle(userManager.textColor)
                                            .font(.caption2)
                                    }
                                    .onTapGesture {
                                        business.totalTime -= 60
                                    }
                            }
                            
                            Spacer()
                        }
                        .foregroundStyle(getColor(business.businessTheme))
                        .frame(width: 160, height: 80,alignment: .leading)
                    }
            }
    }
}

#Preview {
    Settings()
        .environmentObject(UserManager())
}

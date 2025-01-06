//
//  Settings.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 05/10/2024.
//

import SwiftUI
import SwiftData

struct Settings: View {

    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @Query var users: [UserDataModel]
    @Query var businesses: [BusinessDataModel] // Query for businesses
    @EnvironmentObject var themeManager: ThemeManager
    @State var isDarkMode = "black"
    

    let emailAddress = "Kianbreslin517@gmail.com"
    var colorsArray: [String] = ["Red", "Blue", "Green", "Pink", "Purple", "Black", "White"]
    var currencyArray: [String] = ["$", "£", "€"]
    @State var isOn = false
    @State var isColorSelected = 0
    @State var isCurrencySelected = 0

    var body: some View {
        NavigationStack { // Wrap everything in a NavigationStack
            ZStack {
                themeManager.mainColor
                    .ignoresSafeArea()

                VStack {
                    HStack {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 25))
                            .fontWeight(.heavy)
                            .onTapGesture {
                                dismiss()
                            }

                        Spacer()

                        Text("Settings")
                            .font(.system(size: 40))

                        Spacer()

                        Image(systemName: "arrow.right")
                            .font(.system(size: 25))
                            .foregroundStyle(themeManager.mainColor)
                    }
                    .padding()

                    NavigationLink(destination: SettingsNavigation(textForView: "Profile Settings")) {
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: screenWidth-20, height: 100)
                                .opacity(0.1)
                            HStack {
                                Image("userImage-2")
                                    .resizable()
                                    .frame(width: 90, height: 90)
                                VStack(alignment: .leading) {
                                    Text("\(users.first?.username ?? "No User Found")")
                                    Text("\(users.first?.email ?? "No User Found)")")
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 15))
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                        }
                        .padding()
                    }

                    // Appearance
                    VStack(alignment: .leading) {
                        Text("Appearance")
                            .font(.system(size: 15))
                            .opacity(0.7)
                        Toggle("Dark Mode:", isOn: $themeManager.isDarkMode)
                        HStack {
                            Text("Color Mode: ")
                            Spacer()
                            ForEach(0..<7) { i in
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(getColor(colorsArray[i]))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 2)
                                            .stroke(i == isColorSelected ? themeManager.textColor : Color.clear, lineWidth: 3)
                                    )
                                    .onTapGesture {
                                        isColorSelected = i // Update selected color
                                        themeManager.secondaryColor = colorsArray[i]
                                    }
                            }
                        }
                    }
                    .padding()

                    ScrollView {
                        VStack(alignment: .leading) {
                            // General Section
                            VStack(alignment: .leading) {
                                Text("General")
                                    .font(.system(size: 15))
                                    .opacity(0.7)
                                    .padding(.bottom)

                                // Notifications
                                NavigationLink(destination: SettingsNavigation(textForView: "Notifications")) {
                                    HStack {
                                        Text("Notifications")
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                    }
                                }

                                Divider()

                                // Currency Selection
                                HStack {
                                    Text("Currency: ")
                                    Spacer()
                                    ForEach(0..<3) { i in
                                        RoundedRectangle(cornerRadius: 5)
                                            .frame(width: 30, height: 30)
                                            .foregroundStyle(themeManager.mainColor)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 5)
                                                    .stroke(i == isCurrencySelected ? themeManager.textColor : Color.clear, lineWidth: 3)
                                                Text("\(currencyArray[i])")
                                            }
                                            .onTapGesture {
                                                isCurrencySelected = i
                                            }
                                    }
                                }
                            }
                            .padding()

                            // Redeem Section
                            VStack(alignment: .leading) {
                                Text("Redeem")
                                    .font(.system(size: 15))
                                    .opacity(0.7)
                                    .padding(.bottom)

                                // Redeem Rewards
                                NavigationLink(destination: SettingsNavigation(textForView: "Redeem")) {
                                    HStack {
                                        Text("Redeem Rewards Here")
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                    }
                                }
                            }
                            .padding()

                            // About Section
                            VStack(alignment: .leading) {
                                Text("About")
                                    .font(.system(size: 15))
                                    .opacity(0.7)
                                    .padding(.bottom)

                                // About BusyBuilders
                                NavigationLink(destination: SettingsNavigation(textForView: "About")) {
                                    HStack {
                                        Text("About BusyBuilders")
                                        Spacer()
                                        Image(systemName: "info.circle")
                                    }
                                }

                                Divider()

                                // Support Me
                                NavigationLink(destination: SettingsNavigation(textForView: "Support Me!")) {
                                    HStack {
                                        Text("Support Me!")
                                        Spacer()
                                        Image(systemName: "hands.sparkles")
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                    .background(themeManager.mainColor)

                    Spacer()
                }
            }
            .foregroundStyle(themeManager.textColor)
        }
    }
}

#Preview {
    Settings()
        .environmentObject(ThemeManager())
}

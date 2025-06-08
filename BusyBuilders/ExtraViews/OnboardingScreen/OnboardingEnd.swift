//
//  OnboardingEnd.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 19/11/2024.
//

import SwiftUI
import SwiftData

struct OnboardingEnd: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var userManager: UserManager
    @Query var users: [UserDataModel]
    @Environment(\.modelContext) var context
    
    @Binding var currentScreen : Int
    @State var load = false
    
    var body: some View {
        ZStack {
            themeManager.mainColor
                .ignoresSafeArea()
            
            VStack (spacing: 15){
                
                HStack (alignment: .bottom){
                    Text("Thank You,")
                        .font(.system(size: 25))
                    
                    Text("\(users.first?.username ?? "Kimmy")")
                        .font(.system(size: 30))
                        .foregroundStyle(getColor(themeManager.secondaryColor))
                }
                
                Text("You've completed the set-up")
                Text("Click the button to Start Earning!")
                
                Spacer()
                HStack {
                    Spacer()
                    Circle()
                        .frame(width: 70, height: 70)
                        .padding()
                        .overlay {
                            Circle()
                                .trim(from: 0, to: load ? 1 : 0.66)
                                .stroke(lineWidth: 5)
                                .rotationEffect(Angle(degrees: -90))
                                .frame(width: 75, height: 75)
                                .foregroundStyle(getColor(themeManager.secondaryColor))
                            Image(systemName: "checkmark")
                                .font(.system(size: 30))
                                .foregroundStyle(themeManager.mainColor)
                                .bold()
                        }
                }
                .animation(.linear(duration: 1), value: load)
                .onAppear {
                    load.toggle()
                }
                .onTapGesture {
                    currentScreen += 1
                    userManager.isUserCreated = true
                    // Run Investment Company Code Initialize
                    
                    let companies: [CompanyDataModel] = [
                        CompanyDataModel(id: UUID(), name: "Techify", location: "New York", icon: "desktopcomputer", stockPrice: 120, stocksAvailable: 1000, stockHistory: [115, 118, 120], stockVolatility: "Medium"),
                        CompanyDataModel(id: UUID(), name: "GreenCore", location: "Dublin", icon: "leaf.fill", stockPrice: 55, stocksAvailable: 800, stockHistory: [50, 52, 55], stockVolatility: "Low"),
                        CompanyDataModel(id: UUID(), name: "HealthPlus", location: "Berlin", icon: "heart.fill", stockPrice: 3000, stocksAvailable: 200, stockHistory: [2800, 2950, 3000], stockVolatility: "High"),
                        CompanyDataModel(id: UUID(), name: "AutoDrive", location: "Tokyo", icon: "car.fill", stockPrice: 75, stocksAvailable: 1200, stockHistory: [70, 74, 75], stockVolatility: "Low"),
                        CompanyDataModel(id: UUID(), name: "EduSmart", location: "Toronto", icon: "book.fill", stockPrice: 200, stocksAvailable: 950, stockHistory: [190, 195, 200], stockVolatility: "Medium"),
                        CompanyDataModel(id: UUID(), name: "Foodies", location: "Paris", icon: "fork.knife", stockPrice: 1100, stocksAvailable: 600, stockHistory: [1050, 1080, 1100], stockVolatility: "Medium"),
                        CompanyDataModel(id: UUID(), name: "BuildIt", location: "Chicago", icon: "hammer.fill", stockPrice: 500, stocksAvailable: 750, stockHistory: [470, 490, 500], stockVolatility: "Low"),
                        CompanyDataModel(id: UUID(), name: "CloudNet", location: "San Francisco", icon: "cloud.fill", stockPrice: 1500, stocksAvailable: 400, stockHistory: [1450, 1480, 1500], stockVolatility: "High"),
                        CompanyDataModel(id: UUID(), name: "MediaWave", location: "London", icon: "tv.fill", stockPrice: 85, stocksAvailable: 1300, stockHistory: [83, 84, 85], stockVolatility: "Low"),
                        CompanyDataModel(id: UUID(), name: "TravelX", location: "Sydney", icon: "airplane", stockPrice: 2500, stocksAvailable: 350, stockHistory: [2400, 2450, 2500], stockVolatility: "High")
                    ]
                    
                    for company in companies {
                        context.insert(company)
                    }
                }
            }
            
        }
        .foregroundStyle(themeManager.textColor)
    }
}

#Preview {
    OnboardingEnd(currentScreen: .constant(0))
        .environmentObject(ThemeManager())
        .environmentObject(UserManager())
}

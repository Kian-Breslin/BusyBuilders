//
//  TimerConfig V2.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 23/01/2025.
//

import SwiftUI
import SwiftData

struct TimerConfig_V2: View {
    @EnvironmentObject var themeManager : ThemeManager
    @Query var users: [UserDataModel]
    
    @State var selectedBusiness = BusinessDataModel(businessName: "", businessTheme: "", businessType: "", businessIcon: "")
    
    @State var sessionCounts = 4.0
    @State var shortBreakTime = 5.0
    @State var longBreakTime = 20.0
    
    @Binding var isTimerActive : Bool
    
    var body: some View {
            
        VStack (alignment: .leading){
            Text("Timer")
                .font(.system(size: 30, weight: .bold))
                .foregroundStyle(getColor(themeManager.secondaryColor))
                .padding(.vertical, 10)
            
            VStack (alignment: .leading, spacing: 0){
                Text("Businesses")
                    .bold()
                    .font(.system(size: 15))
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack {
                        if let user = users.first {
                            ForEach(user.businesses) { business in
                                businessCard(business: business, selectedBusiness: $selectedBusiness)
                                    .padding(.vertical, 5)
                            }
                        }
                    }
                    .padding(.horizontal, 5)
                }
                .frame(width: screenWidth-20, alignment: .leading)
            }
            
            VStack (alignment: .leading, spacing: 5){
                Text("Sessions: \(sessionCounts, specifier: "%.f")")
                    .bold()
                    .font(.system(size: 15))
                
                Slider(value: $sessionCounts, in: 0...8, step: 1){
                    Text("Sessions")
                }
                .tint(getColor(themeManager.secondaryColor))
            }
            
            VStack (alignment: .leading, spacing: 5){
                Text("Short Break: \(shortBreakTime, specifier: "%.f") mins")
                    .bold()
                    .font(.system(size: 15))
                
                Slider(value: $shortBreakTime, in: 0...10, step: 1)
                    .tint(getColor(themeManager.secondaryColor))
            }
            
            VStack (alignment: .leading, spacing: 5){
                Text("Long Break: \(longBreakTime, specifier: "%.f") mins")
                    .bold()
                    .font(.system(size: 15))
                
                Slider(value: $longBreakTime, in: 10...30, step: 1)
                    .tint(getColor(themeManager.secondaryColor))
            }
            
            VStack(alignment: .leading, spacing: 5){
                Text("Upgrades")
                    .bold()
                    .font(.system(size: 15))
                
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: ((screenWidth-40)/3), height: 50)
                        .foregroundStyle(themeManager.mainColor)
                        .overlay {
                            Text("Cash Boost")
                        }
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: ((screenWidth-40)/3), height: 50)
                        .foregroundStyle(themeManager.mainColor)
                        .overlay {
                            Text("Cost Reduction")
                        }
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: ((screenWidth-40)/3), height: 50)
                        .foregroundStyle(themeManager.mainColor)
                        .overlay {
                            Text("XP Boost")
                        }
                }
                .font(.system(size: 12))
                .bold()
            }
            Spacer()
            HStack {
                Spacer()
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 150, height: 50)
                    .foregroundStyle(themeManager.mainColor)
                    .overlay {
                        Text("Start Session")
                            .font(.system(size: 15))
                            .bold()
                    }
                    .onTapGesture {
                        isTimerActive.toggle()
                    }
                Spacer()
            }
            .padding(.bottom, 80)
        }
        .frame(width: screenWidth-20, alignment: .leading)
        .foregroundStyle(themeManager.textColor)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .fullScreenCover(isPresented: $isTimerActive) {
            if selectedBusiness.businessName != "" {
                Timer3(selectedBusiness: selectedBusiness, setTime: 3600, isTimerActive: $isTimerActive)
            } else {
                Text("Hello")
            }
        }
    }
}

struct businessCard: View {
    @EnvironmentObject var themeManager : ThemeManager
    var business : BusinessDataModel
    @Binding var selectedBusiness : BusinessDataModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 125, height: 95)
            .foregroundStyle(themeManager.mainColor)
            .shadow(color: getColor("\(business.businessTheme)"), radius: business == selectedBusiness ? 5 : 0, x: 0, y: 0)
            .overlay {
                VStack {
                    Text("\(business.businessName)")
                        .foregroundStyle(getColor("\(business.businessTheme)"))
                        .bold()
                        .padding(.bottom, 1)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Cash/min:")
                                .opacity(0.6)
                            Spacer()
                            Text("$\(business.cashPerMin)")
                                .font(.system(size: 14))
                        }
                        HStack {
                            Text("Cost/min:")
                                .opacity(0.6)
                            Spacer()
                            Text("$\(business.costPerMin)")
                                .font(.system(size: 14))
                        }
                        HStack {
                            Text("Level:")
                                .opacity(0.6)
                            Spacer()
                            Text("\(business.businessLevel)")
                                .font(.system(size: 14))
                        }
                        
                    }
                    .frame(width: 110)
                    .font(.system(size: 10))
                }
            }
            .onTapGesture {
                selectedBusiness = business
            }
    }
}

#Preview {
    ZStack {
        ThemeManager().mainColor.ignoresSafeArea()
        
        
        VStack {
            RoundedRectangle(cornerRadius: 10)
            .frame(width: screenWidth, height: 160)
            .foregroundStyle(ThemeManager().mainColor)
            
            TimerConfig_V2(isTimerActive: .constant(false))
                .environmentObject(ThemeManager())
            
            Spacer()
            
            Rectangle()
                .frame(width: screenWidth, height: 75)
                .foregroundStyle(ThemeManager().mainColor)
                
        }
        .ignoresSafeArea()
    }
}

//
//  TimerConfig.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 19/12/2024.
//

import SwiftUI
import SwiftData

struct TimerConfig: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Query var users : [UserDataModel]
    
    @State var quickCreateBusiness = true
    @State var quickCreateBusinessName = ""
    @Binding var isTimerActive : Bool
    
    @State var selectedBusiness : BusinessDataModel?
    
    //Timer
    @State var timeSelected = 0
    
    @State var isCashBoosterOn = false
    @State var isCostReductionOn = false
    @State var isXPBoostOn = false
    
    var body: some View {
        VStack {
            VStack {
                VStack (alignment: .leading){
                    Text("Select a Business:")
                        .foregroundStyle(themeManager.textColor)
                    ScrollView (.horizontal) {
                        HStack {
                            if let user = users.first {
                                ForEach(user.businesses) { business in
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 150, height: 150)
                                        .foregroundStyle(themeManager.mainColor)
                                        .overlay {
                                            VStack {
                                                RoundedRectangle(cornerRadius: 5)
                                                    .frame(width: 140, height: 50)
                                                    .foregroundStyle(getColor("\(business.businessTheme)"))
                                                    .overlay {
                                                        Text(business.businessName)
                                                    }
                                                    .padding(.top, 5)
                                                HStack {
                                                    Text("$/min: ")
                                                    Spacer()
                                                    Text("$\(business.cashPerMin)")
                                                }
                                                .padding(.horizontal, 5)
                                                
                                                HStack {
                                                    Text("Cost/min: ")
                                                    Spacer()
                                                    Text("$\(business.costPerMin)")
                                                }
                                                .padding(.horizontal, 5)
                                                
                                                HStack {
                                                    Text("Level: ")
                                                    Spacer()
                                                    Text("\(business.businessLevel)")
                                                }
                                                .padding(.horizontal, 5)
                                                
                                                
                                                Spacer()
                                            }
                                            .foregroundStyle(themeManager.textColor)
                                        }
                                        .onTapGesture {
                                            selectedBusiness = business
                                        }
                                }
                            } 
                        }
                    }
                }
                
                upgradeSelect(isCashBoosterOn: $isCashBoosterOn, isCostReductionOn: $isCostReductionOn, isXPBoostOn: $isXPBoostOn)
                .frame(width: screenWidth-20, alignment: .leading)
                
                timeSelect(timeSelected: $timeSelected)
                    .frame(width: screenWidth-20, alignment: .leading)
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 150, height: 50)
                    .foregroundStyle(themeManager.mainColor)
                    .overlay {
                        Text("START")
                            .foregroundStyle(themeManager.textColor)
                            .kerning(3)
                            .font(.system(size: 30))
                    }
                    .onTapGesture {
                        isTimerActive.toggle()
                    }
            }
            .frame(width: screenWidth-20, alignment: .leading)
            
            Spacer()
        }
        .frame(width: screenWidth)
        .fullScreenCover(isPresented: $isTimerActive) {
            if selectedBusiness != nil {
//                Timer3(selectedBusiness: selectedBusiness!, setTime: timeSelected, isTimerActive: $isTimerActive)
            } else {
                Text("Hello")
            }
        }
    }
}

struct upgradeSelect: View {
    
    @Binding var isCashBoosterOn : Bool
    @Binding var isCostReductionOn : Bool
    @Binding var isXPBoostOn : Bool
    
    
    var body: some View {
        VStack (alignment: .leading){
            Text("Upgrages: ")
                .foregroundStyle(ThemeManager().textColor)
            HStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 50, height: 50)
                    .foregroundStyle(ThemeManager().mainColor)
                    .opacity(isCashBoosterOn ? 1 : 0.7)
                    .overlay {
                        Image(systemName: "arrow.up")
                            .foregroundStyle(ThemeManager().textColor)
                    }
                    .onTapGesture {
                        isCashBoosterOn.toggle()
                    }
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 50, height: 50)
                    .foregroundStyle(ThemeManager().mainColor)
                    .opacity(isCostReductionOn ? 1 : 0.7)
                    .overlay {
                        Image(systemName: "arrow.down")
                            .foregroundStyle(ThemeManager().textColor)
                    }
                    .onTapGesture {
                        isCostReductionOn.toggle()
                    }
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 50, height: 50)
                    .foregroundStyle(ThemeManager().mainColor)
                    .opacity(isXPBoostOn ? 1 : 0.7)
                    .overlay {
                        Image(systemName: "dollarsign")
                            .foregroundStyle(ThemeManager().textColor)
                    }
                    .onTapGesture {
                        isXPBoostOn.toggle()
                    }
            }
            .font(.system(size: 25))
        }
    }
}

struct timeSelect: View {
    
    @Binding var timeSelected : Int
    var body: some View {
        VStack (alignment: .leading){
            Text("Time: ")
                .foregroundStyle(ThemeManager().textColor)
            
            HStack {
                Spacer()
//                TimeSelect(moveFiveMins: $timeSelected)
                VStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 200, height: 50)
                        .overlay {
                            Text("\(timeFormatted(timeSelected))")
                                .foregroundStyle(ThemeManager().textColor)
                                .font(.system(size: 30))
                        }
                    HStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 95, height: 50)
                            .overlay {
                                Image(systemName: "plus")
                                    .foregroundStyle(ThemeManager().textColor)
                            }
                            .onTapGesture {
                                timeSelected += 300
                            }
                        
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 95, height: 50)
                            .overlay {
                                Image(systemName: "minus")
                                    .foregroundStyle(ThemeManager().textColor)
                            }
                            .onTapGesture {
                                timeSelected -= 300
                            }
                    }
                }
                Spacer()
            }
            
            
        }
        .foregroundStyle(ThemeManager().mainColor)
    }
}

#Preview {
    TimerConfig(isTimerActive: .constant(false))
        .environmentObject(ThemeManager())
}

//
//  BusinessNavigationDestination.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 13/11/2024.
//

import SwiftUI
import SwiftData

struct BusinessNavigationDestination: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @Query var users : [UserDataModel]
    @State var business : BusinessDataModel
    
    @State var isSellingBusiness = false
    @State var isWithdrawingMoney = false
    @State var isAddingMoney = false
    @State var isShowingUpgrades = false
    
    var body: some View {
        ZStack {
            getColor("\(business.businessTheme)")
                .ignoresSafeArea()
            VStack {
                HStack {
                    Text("\(business.businessName)")
                        .bold()
                        
                    
                    Spacer()
                    
                    NavigationLink (destination: BusinessSettings(business: business)) {
                        Image(systemName: "gearshape.fill")
                    }
                }
                .frame(width: screenWidth-20)
                .font(.system(size: 30))
                .foregroundStyle(themeManager.textColor)
                
                ScrollView (.vertical, showsIndicators: false){
                    VStack (alignment: .leading){
                        Group {
                            Text("Total Net Worth")
                            Text("$\(business.netWorth)")
                                .font(.system(size: 35))
                        }
                        Group {
                            Text("Prestige")
                            Text("\(getPrestige(getLevelFromSec(business.businessLevel)))")
                                .font(.system(size: 35))
                        }
                        Group {
                            Text("Level")
                            Text("\(getLevelFromSec(business.businessLevel))")
                                .font(.system(size: 35))
                        }
                        Group {
                            Text("Total Study Time")
                            Text("\(timeFormattedWithText(business.time))")
                                .font(.system(size: 35))
                        }
                        Group {
                            Text("Withdraw / Add Money")
                            HStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 150, height: 50)
                                    .foregroundStyle(themeManager.textColor)
                                    .overlay {
                                        Text("Withdraw")
                                            .foregroundStyle(themeManager.mainColor)
                                            .bold()
                                    }
                                    .onTapGesture {
                                        isWithdrawingMoney.toggle()
                                    }
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 150, height: 50)
                                    .foregroundStyle(themeManager.textColor)
                                    .overlay {
                                        Text("Add")
                                            .foregroundStyle(themeManager.mainColor)
                                            .bold()
                                    }
                                    .onTapGesture {
                                        isAddingMoney.toggle()
                                    }
                            }
                        }
                        
                        Group {
                            Text("Upgrades")
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 150, height: 50)
                                .foregroundStyle(themeManager.textColor)
                                .overlay {
                                    Text("Upgrades")
                                        .foregroundStyle(themeManager.mainColor)
                                        .bold()
                                }
                                .onTapGesture {
                                    isShowingUpgrades.toggle()
                                }
                        }
                    }
                    .frame(width: screenWidth-20, alignment: .leading)
                    
                    }
                    .padding(.top, 5)
                
                Spacer()
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 150, height: 50)
                    .foregroundStyle(themeManager.textColor)
                    .overlay {
                        Text("Sell Business")
                            .bold()
                            .foregroundStyle(themeManager.mainColor)
                    }
                    .padding(.bottom, 65)
                    .onTapGesture {
                        isSellingBusiness.toggle()
                    }
                }
            }
            .foregroundStyle(themeManager.textColor)
            .sheet(isPresented: $isSellingBusiness) {
                VStack (alignment: .leading){
                    Text("Confrimation")
                        .bold()
                        .font(.system(size: 30))
                        .padding(.top, 10)
                    Text("Are you sure you want to ") + Text("sell ").bold().foregroundStyle(.red).font(.system(size: 20)) + Text("\(business.businessName)?")
                    Text("Current Net Worth: ") + Text("$\(business.netWorth)").bold()
                    Text("This cannot be undone!")
                    
                    HStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: (screenWidth-30)/2, height: 50)
                            .foregroundStyle(getColor("Green"))
                            .onTapGesture {
                                if let user = users.first {
                                    user.businesses.removeAll{$0.businessName == business.businessName}
                                    user.availableBalance += business.netWorth
                                    let newTransaction = TransactionDataModel(category: "Other", amount: business.netWorth, transactionDescription: "Sold \(business.businessName)", createdAt: Date(), income: true)
                                    user.transactions.append(newTransaction)
                                    print("Sold \(business.businessName) for $\(business.netWorth)")
                                    do {
                                        try context.save()
                                    } catch {
                                        print("Coudlnt sell Business")
                                    }
                                } else {
                                    print("\(business.businessName) sold for $\(business.netWorth)")
                                }
                                isSellingBusiness.toggle()
                                dismiss()
                            }
                            .overlay {
                                Text("Confirm").bold()
                            }
                        
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: (screenWidth-30)/2, height: 50)
                            .foregroundStyle(getColor("red"))
                            .onTapGesture {
                                isSellingBusiness.toggle()
                            }
                            .overlay {
                                Text("Go Back").bold()
                            }
                    }
                    .foregroundStyle(.white)
                    .padding(.top, 20)
                    
                    Spacer()
                }
                .frame(width: screenWidth-20, alignment: .leading)
                .presentationDetents([.fraction(0.25)])
            }
            .sheet(isPresented: $isWithdrawingMoney) {
                WithdrawMoneyFromBusiness(user: users.first ?? UserDataModel(username: "Keano517", name: "Kian Breslin", email: "Kianbreslin517@gmail.com"), business: business, isWithdrawingMoney: $isWithdrawingMoney)
                    .presentationDetents([.fraction(0.3)])
            }
            .sheet(isPresented: $isAddingMoney) {
                AddMoneyToBusiness(user: users.first ?? UserDataModel(username: "Keano517", name: "Kian Breslin", email: "Kianbreslin517@gmail.com"), business: business, isWithdrawingMoney: $isAddingMoney)
                    .presentationDetents([.fraction(0.3)])
            }
//            .fullScreenCover(isPresented: $isShowingUpgrades) {
//                
//            }
    }
}

#Preview {
    BusinessNavigationDestination(business: BusinessDataModel(
        businessName: "Kians Shop",
        businessTheme: "Blue",
        businessType: "Economic",
        businessIcon: "triangle",
        owners: [UserDataModel(username: "Kian_17", name: "Kian", email: "Kianbreslin@gmail.com")],
        time: 9360,
        netWorth: 60000,
        investors: [
            UserDataModel(username: "LilKimmy", name: "Kim", email: "Kim@gmail.com"),
            UserDataModel(username: "LilJimmy", name: "Jim", email: "Jim@gmail.com"),
            UserDataModel(username: "LilLimmy", name: "Lim", email: "Lim@gmail.com"),
            UserDataModel(username: "LilPimmy", name: "Pim", email: "Pim@gmail.com"),
            UserDataModel(username: "LilTimmy", name: "Tim", email: "Tim@gmail.com"),
            UserDataModel(username: "LilRimmy", name: "Rim", email: "Rim@gmail.com")
        ],
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
        businessPrestige: "Growing Business"))
    .environmentObject(ThemeManager())
}

//
//  bankSettingsView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 08/01/2025.
//


import SwiftUI
import SwiftData

struct bankSettingsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State var user : UserDataModel
    let banks : [BankDataModel] = [
        BankDataModel(name: "Ace Bank", icon: "suit.spade", loanInterestRate: 0.03, savingsInterestRate: 0.04, benefits: []),
        BankDataModel(name: "Hearts Bank", icon: "suit.heart", loanInterestRate: 0.05, savingsInterestRate: 0.02, benefits: []),
        BankDataModel(name: "Diamond Bank", icon: "suit.diamond", loanInterestRate: 0.02, savingsInterestRate: 0.05, benefits: []),
        BankDataModel(name: "Clubs Bank", icon: "suit.club", loanInterestRate: 0.03, savingsInterestRate: 0.03, benefits: [])
    ]
    
    var body: some View {
        ZStack {
            themeManager.mainColor.ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("\(user.bank!.name)")
                        .font(.system(size: 30))
                    Image(systemName: "\(user.bank!.icon)")
                        .font(.system(size: 30))
                }
                .padding(.bottom, 30)
                
                VStack (alignment : .leading, spacing: 10){
                    Text("Details")
                        .font(.system(size: 20))
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: screenWidth-20, height: 90)
                        .foregroundStyle(getColor(themeManager.mainDark))
                        .overlay {
                            VStack (alignment: .leading){
                                Text("Loan Interest Rate: \((user.bank!.loanInterestRate)*100, specifier: "%.f")%")
                                    
                                Text("Savings Interest Rate: \((user.bank!.savingsInterestRate)*100, specifier: "%.f")%")
                                
                                Text("Credit Score Needed: 800")
                            }
                            .frame(width: screenWidth-40, alignment: .leading)
                        }
                    
                    Text("Upgrades")
                        .font(.system(size: 20))
                    
                    HStack {
                        bankUpgradeView()
                    }
                    .foregroundStyle(themeManager.textColor)
                    
                    
                    Text("Other Banks")
                        .font(.system(size: 20))
                    
                    otherBanksView(banks: banks, user: user)
                    
                }
            }
            .foregroundStyle(themeManager.textColor)
            .frame(width: screenWidth-20)
        }
    }
}

struct otherBanksView: View {
    @EnvironmentObject var themeManager : ThemeManager
    @State var banks : [BankDataModel]
    @State var user : UserDataModel
    
    var body: some View {
        ScrollView (.horizontal){
            HStack {
                ForEach(banks){ i in
                    if i.name != user.bank!.name {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 300, height: 160)
                            .foregroundStyle(getColor(themeManager.mainDark))
                            .padding(.vertical, 10)
                            .overlay {
                                VStack (alignment: .leading){
                                    Text(i.name)
                                        .padding(.bottom, 15)
                                        .font(.system(size: 20))
                                    
                                    Text("Loan Interest Rate: \((i.loanInterestRate)*100, specifier: "%.f")%")
                                    Text("Savings Interest Rate: \((i.savingsInterestRate)*100, specifier: "%.f")%")
                                    Text("Credit Score Required: 1000")
                                    
                                    Spacer()
                                    
                                    HStack {
                                        Spacer()
                                        Button("Apply"){
                                            print("Applied for \(i.name)")
                                        }
                                        .frame(width: 80, height: 40)
                                        .background(getColor(themeManager.secondaryColor))
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                }
                                .font(.system(size: 15))
                                .frame(width: 280, height: 120, alignment: .leading)
                            }
                    }
                }
            }
    }
    .frame(width: screenWidth-20, alignment: .leading)
    .font(.system(size: 15))
    }
}
struct bankUpgradeView: View {
    @EnvironmentObject var themeManager : ThemeManager
    @State var level = 0
    @State var progress = 0
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: ((screenWidth-30)/2), height: 150)
            .foregroundStyle(getColor(themeManager.mainDark))
            .overlay {
                VStack (alignment: .leading){
                    Text("Loan")
                        .font(.system(size: 25))
                    Spacer()
                    HStack {
                        Text("\(level)")
                            .frame(width: 20, height: 15)
                        Spacer()
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 110, height: 10)
                            .overlay (alignment: .leading){
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: CGFloat(progress), height: 10)
                                    .foregroundStyle(getColor(themeManager.secondaryColor))
//                                    .padding(.horizontal, 5)
                                }
                        Spacer()
                        Text("\(level + 1)")
                            .frame(width: 20, height: 15)
                    }
                    .font(.system(size: 10))
                    Spacer()
                    Button("Upgrade"){
                        if progress <= 88 {
                            level += 1
                            progress += 11
                        } else {
                            level += 1
                            progress = 0
                        }
                        print(progress)
                        
                    }
                    .frame(width: 80, height: 40)
                    .background(getColor(themeManager.secondaryColor))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.vertical, 10)
                .foregroundStyle(themeManager.textColor)
                .frame(width: ((screenWidth-30)/2)-20, alignment: .leading)
            }
            .animation(.linear, value: level)
    }
}

#Preview {
    bankUpgradeView()
        .environmentObject(ThemeManager())
}

//#Preview {
//    bankSettingsView(user: UserDataModel(username: "Keano517", name: "Kian", email: "kianbreslin@gmail.com", bank: BankDataModel(name: "Ace Bank", icon: "suit.spade", loanInterestRate: 0.05, savingsInterestRate: 0.05, benefits: [])))
//        .environmentObject(ThemeManager())
//}

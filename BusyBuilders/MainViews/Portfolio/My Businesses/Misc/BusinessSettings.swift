//
//  BusinessSettings.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 13/11/2024.
//

import SwiftUI
import SwiftData

struct BusinessSettings: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @Environment(\.modelContext) var context
    @State var business : BusinessDataModel
    @State var confirmDeleteOwner = false
    @State var confirmDeleteInvestor = false
    @State var selectedOwner : UserDataModel?
    @State var selectedInvestor : UserDataModel?
    
    let colorNames: [String] = ["Red", "Blue", "Green", "Yellow", "Pink", "Purple"]
    let iconNames: [String] = ["triangle", "diamond", "pentagon", "shield", "rhombus", "hexagon"]

    var body: some View {
        ZStack {
            getColor("\(business.businessTheme)")
                .ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 250, height: 150)
                .foregroundStyle(themeManager.mainColor)
                .overlay {
                    VStack {
                        Text("Confirm Deletion")
                            .bold()
                            .foregroundStyle(themeManager.textColor)
                        Spacer()
                        Text("Are you sure you want to delete \(selectedOwner?.username ?? "")?")
                            .font(.system(size: 15))
                            .multilineTextAlignment(.center)
                       
                        Spacer()
                        HStack {
                            Text("Back")
                                .font(.system(size: 20))
                                .foregroundStyle(getColor("blue"))
                                .frame(width: 120)
                                .onTapGesture {
                                    confirmDeleteOwner.toggle()
                                }
                            Rectangle()
                                .frame(width: 2, height: 20)
                                .opacity(0.5)
                                .foregroundStyle(themeManager.textColor)
                            Text("Confirm")
                                .foregroundStyle(getColor("red"))
                                .font(.system(size: 20))
                                .frame(width: 120)
                                .onTapGesture {
                                    
                                    if business.Owners.count > 1{
                                        getOwnerIndexInBusiness(business: business, ownerUUID: selectedOwner!.id)
                                        print("Deleted: \(selectedOwner?.username ?? "")")
                                    }
                                    do {
                                        try context.save()
                                        confirmDeleteOwner.toggle()
                                    } catch {
                                        print("Error Deleting Business")
                                    }
                                }
                        }
                    }
                    .padding()
                    .foregroundStyle(themeManager.textColor)
                }
                .opacity(confirmDeleteOwner ? 1 : 0)
                .zIndex(99)
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 250, height: 150)
                .foregroundStyle(themeManager.mainColor)
                .overlay {
                    VStack {
                        Text("Confirm Deletion")
                            .bold()
                            .foregroundStyle(themeManager.textColor)
                        Spacer()
                        Text("Are you sure you want to delete \(selectedInvestor?.username ?? "")?")
                            .font(.system(size: 15))
                            .multilineTextAlignment(.center)
                       
                        Spacer()
                        HStack {
                            Text("Back")
                                .font(.system(size: 20))
                                .foregroundStyle(getColor("blue"))
                                .frame(width: 120)
                                .onTapGesture {
                                    confirmDeleteInvestor.toggle()
                                }
                            Rectangle()
                                .frame(width: 2, height: 20)
                                .opacity(0.5)
                                .foregroundStyle(themeManager.textColor)
                            Text("Confirm")
                                .foregroundStyle(getColor("red"))
                                .font(.system(size: 20))
                                .frame(width: 120)
                                .onTapGesture {
                                    getInvestorIndexInBusiness(business: business, investorUUID: selectedInvestor!.id)
                                    print("Deleted: \(selectedInvestor?.username ?? "")")

                                    do {
                                        try context.save()
                                        confirmDeleteInvestor.toggle()
                                    } catch {
                                        print("Error Deleting Business")
                                    }
                                }
                        }
                    }
                    .padding()
                    .foregroundStyle(themeManager.textColor)
                }
                .opacity(confirmDeleteInvestor ? 1 : 0)
                .zIndex(99)
            
            VStack (alignment: .leading){
                Image(systemName: "\(business.businessIcon)")
                    .font(.system(size: 100))
                    .frame(width: screenWidth-20,height: 150, alignment: .center)
                
                VStack (alignment: .leading, spacing: 0){
                    Text("Business Name")
                        .foregroundStyle(themeManager.textColor)
                        .font(.system(size: 15))
                        .opacity(0.8)
                    TextField("\(business.businessName)", text: $business.businessName)
                        .font(.system(size: 30))
                }
                
                VStack (alignment: .leading, spacing: 5){
                    Text("Business Theme")
                        .foregroundStyle(themeManager.textColor)
                        .font(.system(size: 15))
                        .opacity(0.8)
                    
                    HStack {
                        ForEach(0..<6){ i in
                            RoundedRectangle(cornerRadius: 5).tag(colorNames[i])
                                .frame(width: 55, height: 55)
                                .opacity(business.businessTheme == colorNames[i] ? 1 : 0)
                                .overlay{
                                    RoundedRectangle(cornerRadius: 2).tag(colorNames[i])
                                        .frame(width: 50, height: 50)
                                        .foregroundStyle(getColor("\(colorNames[i])"))
                                        .onTapGesture {
                                            business.businessTheme = colorNames[i]
                                        }
                                }
                            Spacer()
                        }
                    }
                    .frame(width: screenWidth-20, alignment: .leading)
                }
                
                VStack (alignment: .leading, spacing: 5){
                    Text("Business Icon")
                        .foregroundStyle(themeManager.textColor)
                        .font(.system(size: 15))
                        .opacity(0.8)
                    
                    HStack {
                        ForEach(0..<6){ i in
                            RoundedRectangle(cornerRadius: 5).tag(colorNames[i])
                                .frame(width: 55, height: 55)
                                .opacity(business.businessIcon == iconNames[i] ? 1 : 0)
                                .overlay{
                                    RoundedRectangle(cornerRadius: 2).tag(colorNames[i])
                                        .frame(width: 50, height: 50)
                                        .foregroundStyle(getColor("\(business.businessTheme)"))
                                        .overlay {
                                            Image(systemName: "\(iconNames[i])")
                                                .font(.system(size: 40))
                                                .frame(width: 50, height: 50)
                                        }
                                    
                                }
                                .onTapGesture {
                                    business.businessIcon = iconNames[i]
                                }
                            Spacer()
                        }
                    }
                    .frame(width: screenWidth-20, alignment: .leading)
                }
                
                VStack (alignment: .leading, spacing: 0){
                    Text("Owners")
                        .foregroundStyle(themeManager.textColor)
                        .font(.system(size: 15))
                        .opacity(0.8)
                    
                    ScrollView (.horizontal, showsIndicators: false){
                        HStack {
                            ForEach(business.Owners){ o in
                                NavigationLink (destination: ownerItem(user: o)){
                                    RoundedRectangle(cornerRadius: 5)
                                        .onLongPressGesture(minimumDuration: 1) {
                                            selectedOwner = o
                                            confirmDeleteOwner.toggle()
                                        }
                                        .foregroundStyle(themeManager.textColor)
                                        .frame(width: 100, height: 30)
                                        .overlay {
                                            Text("\(o.username)")
                                                .foregroundStyle(themeManager.mainColor)
                                        }
                                        .padding(.vertical, 10)
                                        
                                }
                            }
                        }
                    }
                }
                
                VStack (alignment: .leading, spacing: 0){
                    Text("Investors")
                        .foregroundStyle(themeManager.textColor)
                        .font(.system(size: 15))
                        .opacity(0.8)
                    
                    ScrollView (.horizontal, showsIndicators: false){
                        HStack {
                            ForEach(business.investors){ i in
                                NavigationLink (destination: ownerItem(user: i)){
                                    RoundedRectangle(cornerRadius: 5)
                                        .onLongPressGesture(minimumDuration: 1) {
                                            selectedInvestor = i
                                            confirmDeleteInvestor.toggle()
                                        }
                                        .foregroundStyle(themeManager.textColor)
                                        .frame(width: 100, height: 30)
                                        .overlay {
                                            Text("\(i.username)")
                                                .foregroundStyle(themeManager.mainColor)
                                        }
                                        .padding(.vertical, 10)
                                }
                            }
                        }
                    }
                }
                Spacer()
                
            }
            .padding()
            .blur(radius: confirmDeleteInvestor || confirmDeleteOwner ? 5 : 0)
        }
    }
    func getOwnerIndexInBusiness(business: BusinessDataModel, ownerUUID: UUID){
        let owner = business.Owners.firstIndex { $0.id == ownerUUID }
        
        business.Owners.remove(at: owner!)
    }
    func getInvestorIndexInBusiness(business: BusinessDataModel, investorUUID: UUID){
        let investor = business.investors.firstIndex { $0.id == investorUUID }
        
        business.investors.remove(at: investor!)
    }
}


#Preview {
    BusinessSettings(business: BusinessDataModel(
        businessName: "Kians Shop",
        businessTheme: "Blue",
        businessType: "Economic",
        businessIcon: "triangle",
        owners: [UserDataModel(username: "Kian_17", name: "Kian", email: "Kianbreslin@gmail.com"),UserDataModel(username: "Kim_01", name: "Kimberly", email: "kimberly01leon@gmail.com")],
        time: 9360,
        cashPerMin: 3000,
        netWorth: 6000,
        investors: [
            UserDataModel(username: "Kimmy_9", name: "Kim", email: "Kim@gmail.com"),
            UserDataModel(username: "Jim_00", name: "Jim", email: "Jim@gmail.com"),
            UserDataModel(username: "Jack_99", name: "Jack", email: "Jack@gmail.com"),
            UserDataModel(username: "LilPimmy", name: "Pim", email: "Pim@gmail.com"),
            UserDataModel(username: "LilTimmy", name: "Tim", email: "Tim@gmail.com"),
            UserDataModel(username: "LilYimmy", name: "Yim", email: "Yim@gmail.com")
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
        businessLevel: 7200,
        businessPrestige: "Growing Business"))
    .environmentObject(ThemeManager())
}

//
//  myBusinessesList.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 08/05/2025.
//

import SwiftUI
import SwiftData

struct myBusinessesList: View {
    
    let business : BusinessDataModel
    @Environment(\.modelContext) var context
    @EnvironmentObject var themeManager: ThemeManager
    
    @State var selectedScreen = "Overview"
    let tabs: [(label: String, width: CGFloat)] = [
        ("Overview", 80),
        ("Details", 60),
        ("Stats", 50),
        ("Upgrades", 70),
        ("History", 60),
        ("More Info", 85)
    ]
    
    var body: some View {
        ZStack {
            themeManager.mainColor.ignoresSafeArea()
            
            VStack (spacing: 15){
                HStack (spacing: 15){
                    Image(systemName: "arrow.left")
                    Spacer()
                    Image(systemName: "square.and.arrow.up")
                    Image(systemName: "pin")
                }
                .font(.system(size: 20))
                
                VStack {
                    Image("store")
                        .resizable()
                        .frame(width: 150, height: 100)
                    
                    Text("Business Name")
                        .font(.system(size: 25))
                }
                
                VStack {
                    ScrollView (.horizontal, showsIndicators: false){
                        HStack {
                            ForEach(tabs, id: \.label) { tab in
                                VStack(spacing: 2) {
                                    Text(tab.label)
                                    Rectangle()
                                        .frame(width: tab.width, height: 2)
                                        .opacity(selectedScreen == tab.label ? 1 : 0)
                                }
                                .onTapGesture {
                                    selectedScreen = tab.label
                                }
                            }
                        }
                        .font(.system(size: 15))
                    }
                }
                
                if selectedScreen == "Overview" {
                    BusinessOverview(business: business)
                }
                else if selectedScreen == "Upgrades" {
                    BusinessUpgrades(business: business)
                }
                else if selectedScreen == "History" {
                    BusinessHistory(business: business)
                }
                else if selectedScreen == "More Info" {
                    BusinessMoreInfo(business: business)
                }
                Spacer()
            }
            .foregroundStyle(themeManager.textColor)
            .frame(width: screenWidth-20)
        }
    }
}






#Preview {
    myBusinessesList(business: BusinessDataModel(businessName: "Test Name", businessTheme: "blue", businessType: "Eco", businessIcon: "circle"))
        .modelContainer(for: UserDataModel.self, inMemory: true)
        .environmentObject(ThemeManager())
}

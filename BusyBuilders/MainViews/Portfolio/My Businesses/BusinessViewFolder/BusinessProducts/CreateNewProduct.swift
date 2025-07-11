//
//  CreateNewProduct.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 12/06/2025.
//

import SwiftUI

struct CreateNewProduct: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    let business : BusinessDataModel
    
    @State var productName : String = ""
    @State var productMarkUp : Int = 0
    @State var productType: String = ""
    @State var productIcon: String = ""
    
    //Traits
    @State var productInnovation = 0
    @State var productRetention = 0
    @State var productQuality = 0
    @State var productDesign = 0
    
    var body: some View {
        ZStack {
            themeManager.mainColor.ignoresSafeArea()
            
            VStack(alignment: .leading){
                HStack {
                    Text("Create a Product")
                        .font(.system(size: 35))
                    Spacer()
                    if productIcon != "" {
                        Image(systemName: "\(productIcon.lowercased())")
                    }
                    else {
                        Image(systemName: "square")
                            .font(.system(size: 25))
                    }
                }
                
                textFieldView(text: $productName, title: "Product Name")
                textFieldView(text: $productType, title: "Product Type")
                textFieldView(text: $productIcon, title: "Product Icon")
                
                sliderTraitView(value: $productMarkUp,range: 0...100, step: 5, label: "Product Mark Up")
                sliderTraitView(value: $productInnovation, label: "Innovation")
                sliderTraitView(value: $productRetention, label: "Retention")
                sliderTraitView(value: $productQuality, label: "Quality")
                sliderTraitView(value: $productDesign, label: "Design")
                
                Text("Predicted Cost to Produce: $\(predictedCostToProduce(innovation: productInnovation, quality: productQuality))")
                
                Text("Initial Set Up Cost: $\((productInnovation + productQuality) * 5000)")
                
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: (screenWidth-30)/2, height: 50)
                        .foregroundStyle(getColor("Red"))
                        .overlay {
                            Text("Cancel")
                                .foregroundStyle(themeManager.textColor)
                                .font(.system(size: 25))
                        }
                        .onTapGesture {
                            dismiss()
                        }
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: (screenWidth-30)/2, height: 50)
                        .foregroundStyle(getColor("green"))
                        .overlay {
                            Text("Create")
                                .foregroundStyle(themeManager.textColor)
                                .font(.system(size: 25))
                        }
                        .onTapGesture {
                            let traits = [
                                "Innovation": productInnovation,
                                "Retention": productRetention,
                                "Quality": productQuality,
                                "Design": productDesign
                            ]
                            let newProduct = ProductDataModel(productName: productName, quantity: 0, markupPercentage: productMarkUp, productType: productType, icon: productIcon.lowercased(),traits: traits ,business: business)
                            
                            business.products.append(newProduct)
                            
                            do {
                                try context.save()
                                dismiss()
                            } catch {
                                print("Couldnt Save new Product")
                            }
                        }
                }
            }
            .frame(maxWidth: screenWidth-20, alignment: .leading)
            .foregroundStyle(themeManager.textColor)
            .font(.system(size: 20))
        }
    }
}
func predictedCostToProduce(innovation: Int, quality: Int, baseCost: Int = 100) -> Int {
    let innovationDiscount = Double(innovation) * 0.05 // 5% cost reduction per point
    let qualityPremium = Double(quality) * 0.10        // 10% cost increase per point
    
    let modifiedCost = Double(baseCost) * (1.0 - innovationDiscount + qualityPremium)
    return max(Int(modifiedCost), 1)
}

struct sliderTraitView: View {
    @Binding var value: Int
    var range: ClosedRange<Double> = 0...10
    var step: Double = 1
    var label: String = "Value"
    
    var body: some View {
        VStack (alignment: .leading, spacing: 5){
            Text("\(label): \(value)")
                .bold()
                .font(.system(size: 20))
                .opacity(0.5)
            Slider(value: Binding( get: { Double(value) },set: { value = Int($0) }),
                in: range,
                step: step
            )
        }
    }
}

struct textFieldView: View {
    @Binding var text : String
    let title : String
    var body: some View {
        VStack (alignment: .leading, spacing: 5){
            Text(title)
                .bold()
                .font(.system(size: 20))
                .opacity(0.5)
            TextField("...", text: $text)
                .frame(width: screenWidth-30, height: 30)
                .padding(5)
                .background(ThemeManager().textColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundStyle(ThemeManager().mainColor)
        }
    }
}

#Preview {
    CreateNewProduct(business: BusinessDataModel(businessName: "Fake Name", businessTheme: "red", businessType: "Eco-friendly", businessIcon: "triangle", owners: [], time: 4000, netWorth: 3000000, investment: 0, investors: [], badges: [], upgrades: [], sessionHistory: [SessionDataModel(id: UUID(), sessionDate: Date.now, sessionStart: "01/01/25", sessionEnd: "01/01/25", businessId: UUID(), totalCashEarned: 10000, totalCostIncurred: 1000, totalXPEarned: 7200, totalStudyTime: 7200),SessionDataModel(id: UUID(), sessionDate: Date.now, sessionStart: "01/01/25", sessionEnd: "01/01/25", businessId: UUID(), totalCashEarned: 20000, totalCostIncurred: 1000, totalXPEarned: 7200, totalStudyTime: 7200),SessionDataModel(id: UUID(), sessionDate: Date.now, sessionStart: "01/01/25", sessionEnd: "01/01/25", businessId: UUID(), totalCashEarned: 15000, totalCostIncurred: 1000, totalXPEarned: 7200, totalStudyTime: 7200)], leaderboardPosition: 2, insuranceLevel: 2, securityLevel: 2, businessPrestige: "", streak: 2, creationDate: Date.now))
        .environmentObject(ThemeManager())
}

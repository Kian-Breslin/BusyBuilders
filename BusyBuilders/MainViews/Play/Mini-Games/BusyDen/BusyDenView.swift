//
//  BusyDenView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 27/05/2025.
//

import SwiftUI

struct BusyDenView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @State var InvestorPannel : [Investor] = [makeFakeInvestor(),makeFakeInvestor(),makeFakeInvestor(),makeFakeInvestor()]
    @State var Product : Product
    @State var totalPrice : Int
    @State var createProduct = false
    
    var body: some View {
        ZStack {
            themeManager.mainColor.ignoresSafeArea()
            
            VStack (spacing: 20){
                Text("BusyDen")
                    .font(.system(size: 30))
                
                HStack {
                    ForEach(InvestorPannel){ i in
                        VStack {
                            Text("\(i.name)")
                            HStack {
                                Text("\(i.innovation)")
                                Text("\(i.research)")
                                Text("\(i.design)")
                                Text("\(i.demand)")
                                Text("\(i.scale)")
                            }
                        }
                        .frame(width: (screenWidth-40)/4, height: 100)
                        .background(.blue.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                
                if Product.name == "" {
                    Button("Create Product"){
                        createProduct.toggle()
                    }
                }
                else {
                    VStack (spacing: 15){
                        Text("Product: \(totalPrice)")
                            .underline()
                            .font(.system(size: 20))
                            .bold()
                        
                        VStack {
                            Image(systemName: "\(Product.icon)")
                                .font(.system(size: 30))
                            Text(Product.name)
                                .font(.system(size: 30))
                        }
                        HStack {
                            ScoreCard(ratingName: "Innovation", ratingScore: Product.innovation)
                            ScoreCard(ratingName: "Research", ratingScore: Product.research)
                            ScoreCard(ratingName: "Design", ratingScore: Product.design)
                        }
                        HStack {
                            ScoreCard(ratingName: "Demand", ratingScore: Product.demand)
                            ScoreCard(ratingName: "Scale", ratingScore: Product.scale)
                        }
                    }
                }
                
                Spacer()
                HStack {
                    Button("Simulate"){
                        for investor in InvestorPannel {
                            print(investor.rateProduct(product: Product))
                        }
                    }
                }
            }
            .foregroundStyle(themeManager.textColor)
        }
        .fullScreenCover(isPresented: $createProduct) {
            CreateProductView(newProduct: $Product, totalCalculatedPrice: $totalPrice)
        }
    }
}

struct ScoreCard: View {
    let ratingName : String
    let ratingScore : Int
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 100, height: 80)
            .foregroundStyle(.white)
            .overlay {
                VStack {
                    Text(ratingName)
                    Text("\(ratingScore)")
                }
                .foregroundStyle(.black)
            }
    }
}

#Preview {
    BusyDenView(Product: /*makeFakeProduct(type: 0)*/Product(id: UUID(), name: "", icon: "", innovation: 0, design: 0, research: 0, scale: 0, demand: 0, price: 0), totalPrice: 0)
        .environmentObject(ThemeManager())
}

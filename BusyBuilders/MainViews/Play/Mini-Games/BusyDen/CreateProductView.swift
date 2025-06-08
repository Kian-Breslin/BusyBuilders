//
//  CreateProductView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 29/05/2025.
//

import SwiftUI

struct CreateProductView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.dismiss) var dismiss
    
    @Binding var newProduct: Product
    @Binding var totalCalculatedPrice: Int
    
    @State var changeIcon = false
    @State var productImage = "cup.and.saucer.fill"
    @State var productName = ""
    var productPrice: Int {
        getProductPrice(attributes: [innovation, design, research, scale, demand])
    }
    var totalPrice: Int {
        getTotalPrice(product: productPrice, quantity: Int(quantity))
    }
    
    @State var innovation : Double = 0
    @State var design : Double = 0
    @State var research : Double = 0
    @State var scale : Double  = 0
    @State var demand : Double  = 0
    @State var quantity : Double = 0
    
    var body: some View {
        ZStack {
            themeManager.mainColor.ignoresSafeArea()
            
            VStack (spacing: 15){
                // Product Details
                VStack {
                    Image(systemName: "\(productImage)")
                        .font(.system(size: 80))
                    
                    TextField("Enter Name", text: $productName)
                        .foregroundStyle(themeManager.mainColor)
                        .font(.system(size: 30))
                        .multilineTextAlignment(.center)
                        .background(themeManager.textColor)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .overlay {
                    Image(systemName: "pencil")
                        .offset(x: (screenWidth/2)-20, y: -60)
                        .bold()
                        .font(.system(size: 20))
                        .onTapGesture {
                            changeIcon.toggle()
                        }
                }
                
                VStack (spacing: 15){
                    sliders(name: "Innovation", value: $innovation)
                    sliders(name: "Design", value: $design)
                    sliders(name: "Research", value: $research)
                    sliders(name: "Scale", value: $scale)
                    sliders(name: "Demand", value: $demand)
                }
                VStack (alignment: .leading, spacing: 5){
                    Text("Quantity: \(quantity, specifier: "%.f")")
                        .font(.system(size: 20))
                    Slider(value: $quantity, in: 0...100000, step: 1000)
                }
                
                Text("Product Cost: $\(productPrice)")
                    .font(.system(size: 25))
                
                Text("Total Cost: $\(totalPrice)")
                    .font(.system(size: 25))
                
                Spacer()
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 120, height: 40)
                    .foregroundStyle(.red)
                    .overlay {
                        Text("Create")
                            .font(.system(size: 30))
                    }
                    .onTapGesture {
                        print("Created Product")
                        let product = Product(id: UUID(), name: productName, icon: productImage, innovation: Int(innovation), design: Int(design), research: Int(research), scale: Int(scale), demand: Int(demand))
                        
                        newProduct = product
                        totalCalculatedPrice = totalPrice
                        dismiss()
                    }
                
            }
            .foregroundStyle(themeManager.textColor)
            .frame(width: screenWidth-20)
        }
        .sheet(isPresented: $changeIcon) {
            changeIconView(icon: $productImage)
                .presentationDetents([.fraction(0.25)])
        }
    }
}

struct changeIconView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var icon : String
    let icons = ["cup.and.saucer.fill", "lightbulb.fill", "brain.fill", "bolt.fill", "leaf.fill", "headphones", "book.fill", "table.fill", "display", "drop.fill"]
    var body: some View {
        ZStack {
            themeManager.textColor.ignoresSafeArea()
            VStack (alignment: .leading){
                Text("Chose an Icon")
                    .font(.system(size: 25))
                ScrollView (.horizontal, showsIndicators: false){
                    HStack {
                        ForEach(0..<10){ i in
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 100, height: 100)
                                .overlay {
                                    Image(systemName: "\(icons[i])")
                                        .foregroundStyle(icon == icons[i] ? .red : .white)
                                        .font(.system(size: 60))
                                }
                                .onTapGesture{
                                    icon = icons[i]
                                }
                        }
                    }
                }
            }
            .foregroundStyle(themeManager.mainColor)
            .padding(.horizontal, 10)
        }
    }
}

struct sliders: View {
    let name : String
    @Binding var value: Double
    var body: some View {
        VStack (alignment: .leading, spacing: 5){
            Text("\(name): \(value, specifier: "%.f")")
                .font(.system(size: 20))
            Slider(value: $value, in: 0...10, step: 1)
        }
    }
}

func getProductPrice(attributes: [Double]) -> Int{
    var total = 0.0
    for i in 0...4 {
        total += attributes[i]*5
    }
    return Int(total)
}

func getTotalPrice(product: Int, quantity: Int) -> Int{
    return product * quantity
}

#Preview {
    CreateProductView(newProduct: .constant(Product(id: UUID(), name: "", icon: "", innovation: 0, design: 0, research: 0, scale: 0, demand: 0)), totalCalculatedPrice: .constant(0))
        .environmentObject(ThemeManager())
}

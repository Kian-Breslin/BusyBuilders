//
//  ProductLaunch.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 24/07/2025.
//

import SwiftUI
import SwiftData

struct ProductLaunch: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userManager: UserManager
    @State var business : BusinessDataModel
    @State private var selectedProductID: UUID? = nil
    var body: some View {
        ZStack {
            userManager.mainColor.ignoresSafeArea()
            
            VStack (alignment:.leading, spacing: 20){
                Label("Back", systemImage: "chevron.left")
                    .foregroundStyle(getColor(business.businessTheme))
                    .onTapGesture {
                        dismiss()
                    }
                Spacer()
                VStack (alignment: .leading){
                    Text("My Products")
                        .font(.headline)
                    
                    ScrollViewReader { scrollProxy in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach($business.products, id: \.id) { $product in
                                    ProductCard(selectedProductID: $selectedProductID, product: $product, scrollProxy: scrollProxy)
                                }
                            }
                        }
                    }
                }
                
                customButton(text: "Create a Product", color: getColor(userManager.accentColor), width: 180, height: 40, action: {
                    business.createPreviwProduct()
                    print("Created Project")
                    print("Count: \(business.products.count)")
                })
                Spacer()
            }
            .frame(width: screenWidth-20)
            .foregroundStyle(userManager.textColor)
        }
    }
}

#Preview {
    ProductLaunch(business: BusinessDataModel.previewBusiness)
        .environmentObject(UserManager())
}

struct ProductCard: View {
    @Environment(\.modelContext) var context
    @Query var users : [UserDataModel]
    @EnvironmentObject var userManager: UserManager
    @Binding var selectedProductID : UUID?
    @Binding var product: ProductModel
    @State var scrollProxy: ScrollViewProxy
    var body: some View {
        let isSelected = selectedProductID == product.id
        RoundedRectangle(cornerRadius: 10)
            .fill(.white)
            .frame(
                width: isSelected ? 250 : 150,
                height: 100,
                alignment: .leading
            )
            .overlay(
                HStack {
                    VStack (alignment:.leading){
                        Text("\(product.name)")
                        Label("$\(product.price)", systemImage: "banknote")
                            .font(.caption)
                        Label("\(product.quantity)/10,000", systemImage: "shippingbox")
                            .font(.caption)
                        Label("\(product.rating)", systemImage: "star")
                            .font(.caption)
                        Spacer()
                    }
                    Spacer()
                    if isSelected == true {
                        VStack (alignment:.leading){
                            customButton(text: "Buy Stock", color: getColor(userManager.accentColor), width: 100, height: 30, action: {
                                if let user = users.first {
                                    if user.availableBalance >= 1000 {
                                        do {
                                            product.quantity += 100
                                            user.availableBalance -= 1000
                                            try context.save()
                                        }
                                        catch {
                                            print("Couldnt Save")
                                        }
                                    }
                                }
                            }
                            ,textColor: getColor(userManager.accentColor))
                            
                            customButton(text: "Research", color: getColor(userManager.accentColor), width: 100, height: 30, action: {
                                if let user = users.first {
                                    if user.availableBalance >= 1000 {
                                        do {
                                            product.rating += 1
                                            user.availableBalance -= 1000
                                            try context.save()
                                        }
                                        catch {
                                            print("Couldnt Save")
                                        }
                                    }
                                }
                                
                            }
                            ,textColor: getColor(userManager.accentColor))
                        }

                    }
                    
                }
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            )
            .id(product.id)
            .onTapGesture {
                withAnimation {
                    if selectedProductID == product.id {
                        selectedProductID = nil
                    } else {
                        selectedProductID = product.id
                        scrollProxy.scrollTo(product.id, anchor: .leading)
                    }
                }
            }
    }
}

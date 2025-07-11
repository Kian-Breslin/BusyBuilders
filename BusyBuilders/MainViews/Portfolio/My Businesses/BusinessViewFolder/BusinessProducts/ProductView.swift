//
//  ProductView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 08/06/2025.
//

import SwiftUI
import SwiftData
import Charts

struct ProductView: View {
    @Environment(\.modelContext) var context
    @EnvironmentObject var themeManager: ThemeManager
    let product : ProductDataModel
    
    
    @State var changeProduct = false
    @State var details = "Product Name"
    @State var amount = ""
    
    var body: some View {
        ZStack {
            themeManager.mainColor.ignoresSafeArea()
            
            Circle()
                .frame(width: 40)
                .offset(x: (screenWidth/2)-30, y: -(screenHeight/2)+60)
                .foregroundStyle(product.isActive ? .green : .red)
            
            ScrollView {
                VStack (spacing: 10){
                    Image(systemName: product.icon)
                        .font(.system(size: 100))
                    Text(product.productName)
                        .font(.system(size: 40))
                    Text("Created: \(getDateMonthYear(from: product.productCreationDate) ?? "No Date Found")")
                    
                    VStack (alignment: .leading){
                        HStack {
                            Text("Product Details")
                                .font(.system(size: 30))
                                .bold()
                            Spacer()
                            Image(systemName: "pencil")
                                .font(.system(size: 25))
                                .foregroundStyle(getColor(ThemeManager().secondaryColor))
                                .bold()
                                .onTapGesture {
                                    changeProduct.toggle()
                                }
                        }
                        Text("Type: \(product.productType)")
                        Text("Price per Unit: $\(product.pricePerUnit)")
                        Text("Cost per Unit: $\(product.costToProduce)")
                        Text("Mark Up: \(product.markupPercentage)%")
                        Text("Quantity in Storage: \(product.quantity)")
                        
                        Divider().background(.white)
                        
                        Button("Run Sim"){
                            print("Clicked Button!")
                            product.SellSimulation()
                        }
                        
                        Button("Buy Stock") {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                product.buyStock()
                            }
                        }
                        
                        Button("Delete Product"){
                            
                        }
                        
                        Divider().background(.white)
                        
                        Text("Sales")
                            .font(.system(size: 30))
                            .bold()
                        Text("Total Sold: \(product.soldUnits)")
                        //Put graph here
                        ChartView(sales: true, product: product)
                        
                        Divider().background(.white).padding(.vertical, 20)
                        
                        Text("Price")
                            .font(.system(size: 30))
                            .bold()
                        Text("Current: $\(product.pricePerUnit)")
                        //Put graph here
                        ChartView(sales: false, product: product)
                        

                    }
                    .frame(width: screenWidth-20, alignment: .leading)
                    Spacer()
                }
                .foregroundStyle(themeManager.textColor)
                .font(.system(size: 20))
                .sheet(isPresented: $changeProduct) {
                    ChangeProductDetails(
                        product: product,
                        currentIcon: product.icon,
                        details: $details,
                        amount: $amount,
                        isShowing: $changeProduct
                    )
                    .presentationDetents([.fraction(details == "Product Name" || details == "Mark Up %" ? 0.25 : 0.3)])
                    .interactiveDismissDisabled(true)
                }
            }
            .scrollIndicators(.hidden)
        }
        
    }
}


struct ChartView: View {
    var sales = false
    var product: ProductDataModel
    var priceData: [(session: Int, unitsSold: Int)] {
        product.priceHistory.enumerated().map { (index, value) in
            (session: index + 1, unitsSold: value)
        }
    }
    var salesData: [(session: Int, unitsSold: Int)] {
        product.soldHistory.enumerated().map { (index, value) in
            (session: index + 1, unitsSold: value)
        }
    }

    var body: some View {
        ScrollView(.horizontal) {
            if !priceData.isEmpty {
                Chart {
                    ForEach(sales ? salesData : priceData, id: \.session) { dataPoint in
                        LineMark(
                            x: .value("Session", dataPoint.session),
                            y: .value("Price", dataPoint.unitsSold)
                        )
                        PointMark(
                            x: .value("Session", dataPoint.session),
                            y: .value("Price", dataPoint.unitsSold)
                        )
                    }
                }
                .chartXAxis {
                    AxisMarks(position: .bottom) { value in
                        AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5))
                            .foregroundStyle(.white.opacity(0.3))
                        AxisTick()
                            .foregroundStyle(.white)
                        AxisValueLabel()
                            .foregroundStyle(.white)
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .leading) { value in
                        AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5))
                            .foregroundStyle(.white.opacity(0.3))
                        AxisTick()
                            .foregroundStyle(.white)
                        AxisValueLabel()
                            .foregroundStyle(.white)
                    }
                }
                .foregroundStyle(.white)
                .frame(width: max(CGFloat(sales ? salesData.count : priceData.count) * 40, screenWidth - 40), height: 200)
                .padding(.top, 10)
            }
        }
        .scrollIndicators(.hidden)
    }
}

struct ChangeProductDetails: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.modelContext) var context

    let product: ProductDataModel
    let currentIcon : String
    let mgOptions = ["Product Name", "Icon", "Mark Up %"]
    @Binding var details: String
    @Binding var amount: String
    @Binding var isShowing : Bool
    
    let iconOptions = [
        "iphone",
        "bag.fill",
        "tshirt.fill",
        "desktopcomputer",
        "car.fill",
        "leaf.fill",
        "cup.and.saucer.fill",
        "cube.box.fill",
        "brain.head.profile",
        "gamecontroller.fill"
    ]
    var body: some View {
        ZStack {
            getColor(ThemeManager().mainDark).ignoresSafeArea()
            
            VStack (spacing: 15){
                Menu {
                    Picker("User: ", selection: $details) {
                        ForEach(mgOptions, id: \.self) { opt in
                            Text(opt)
                                .tag(opt)
                        }
                    }
                }label: {
                    HStack {
                        Text("Chose a detail to change:")
                        Spacer()
                        Text(details)
                        Image(systemName: "chevron.up.chevron.down")
                            .font(.headline)
                    }
                    .foregroundStyle(themeManager.textColor)
                    .font(.system(size: 20))
                }
                if (details == "Product Name") {
                    TextField("Name", text: $amount)
                        .padding()
                        .font(.system(size: 25))
                        .frame(width: screenWidth-20, height: 60)
                        .background(themeManager.mainColor)
                        .foregroundStyle(themeManager.textColor)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                else if (details == "Icon") {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0..<10) { i in
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 100, height: 100)
                                    .foregroundStyle(themeManager.mainColor)
                                    .opacity(amount == iconOptions[i] ? 1 : 0.3)
                                    .overlay {
                                        Image(systemName: "\(iconOptions[i])")
                                            .foregroundStyle(amount == iconOptions[i] ? getColor(themeManager.secondaryColor) : themeManager.textColor)
                                            .font(.system(size: 25))
                                    }
                                    .onTapGesture {
                                        amount = iconOptions[i]
                                    }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    .onAppear {
                        amount = currentIcon
                    }
                }
                else if (details == "Mark Up %") {
                    TextField("Name", text: $amount)
                        .padding()
                        .frame(width: screenWidth-20, height: 60)
                        .background(themeManager.mainColor)
                        .foregroundStyle(themeManager.textColor)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .keyboardType(.numberPad)
                }
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 100, height: 50)
                    .foregroundStyle(getColor(themeManager.secondaryColor))
                    .overlay {
                        Text(amount.isEmpty ? "Close" : "Save")
                            .font(.system(size: 25))
                            .foregroundStyle(themeManager.textColor)
                    }
                    .onTapGesture {
                        guard !amount.isEmpty else {
                            isShowing = false
                            return
                        }

                        if details == "Product Name" {
                            product.productName = amount
                        } else if details == "Icon" {
                            product.icon = amount
                        } else if details == "Mark Up %" {
                            product.markupPercentage = Int(amount) ?? 0
                        }

                        do {
                            try context.save()
                        } catch {
                            print("Could not save product changes.")
                        }

                        isShowing = false
                    }
            }
            .padding(10)
            .onAppear {
                amount = ""
            }
        }
    }
}




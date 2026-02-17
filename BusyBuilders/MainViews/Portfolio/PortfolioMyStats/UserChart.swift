//
//  UserChart.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 12/02/2026.
//
import SwiftUI
import SwiftData

struct UserChart: View {
    let values: [Int]
    var total : Double {
        var total = 0.0
        for value in values {
            total += Double(value)
        }
        return total
    }
    
    var amountLenghts : [CGFloat] {
        let value1 = (Double(values[0])/total)
        let value2 = (Double(values[1])/total)
        let value3 = (Double(values[2])/total)
        let value4 = (Double(values[3])/total)
        
        return [value1,value2,value3,value4]
    }
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(UserManager().mainColor)
            .frame(height: 200)
            .overlay {
                VStack (alignment: .leading, spacing: 10){
                    Text("User Chart")
                        .font(.title2)
                    Text("Total Net Worth: $\(total, specifier: "%.f")")
                        .font(.headline)
                    
                    HStack {
                        VStack (alignment: .leading){
                            Text("Available Balance")
                                Spacer()
                            Text("Businesses")
                                Spacer()
                            Text("Items")
                                Spacer()
                            Text("Agencies")
                        }
                        .font(.caption)
                        .padding(.vertical, 10)
                        
                        GeometryReader { geo in
                            let totalWidth = geo.size.width
                            // Compute the longest amount string and measure its width using the same font
                            let amountStrings = values.map { "$\($0)" }
                            let longestAmount = amountStrings.max(by: { $0.count < $1.count }) ?? ""
                            let uiFont = UIFont.preferredFont(forTextStyle: .caption1)
                            let attributes: [NSAttributedString.Key: Any] = [.font: uiFont]
                            let labelWidth = (longestAmount as NSString).size(withAttributes: attributes).width + 8 // small padding
                            let barMaxWidth = max(0, totalWidth - labelWidth)
                            littleGraph()
                                .background {
                                    VStack (alignment: .leading){
                                        HStack(spacing: 5) {
                                            Rectangle()
                                                .fill(getColor("red"))
                                                .frame(width: barMaxWidth*amountLenghts[0], height: 15)
                                            Text("$\(values[0])")
                                                .font(.caption)
                                                .frame(width: labelWidth, alignment: .leading)
                                        }
                                            Spacer()
                                        HStack(spacing: 5) {
                                            Rectangle()
                                                .fill(getColor("blue"))
                                                .frame(width: barMaxWidth*amountLenghts[1], height: 15)
                                            Text("$\(values[1])")
                                                .font(.caption)
                                                .frame(width: labelWidth, alignment: .leading)
                                        }
                                            Spacer()
                                        HStack(spacing: 5) {
                                            Rectangle()
                                                .fill(getColor("green"))
                                                .frame(width: barMaxWidth*amountLenghts[2], height: 15)
                                            Text("$\(values[2])")
                                                .font(.caption)
                                                .frame(width: labelWidth, alignment: .leading)
                                        }
                                            Spacer()
                                        HStack(spacing: 5) {
                                            Rectangle()
                                                .fill(getColor("purple"))
                                                .frame(width: barMaxWidth*amountLenghts[3], height: 15)
                                            Text("$\(values[3])")
                                                .font(.caption)
                                                .frame(width: labelWidth, alignment: .leading)
                                        }
                                    }
                                    .font(.caption2)
                                    .padding(.vertical, 10)
                                    .frame(width: totalWidth, alignment: .leading)
                                }
                        }
                        
                    }
                }
                .frame(maxWidth: .infinity, alignment: .init(horizontal: .leading, vertical: .top))
                .padding(10)
            }
    }
}

struct littleGraph: View {
    var body: some View {
        VStack (alignment: .leading, spacing: 0){
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 2)
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 2)
        }
        
    }
}

#Preview {
    UserChart(values: [20000,100000,50000,800000])
        .padding(10)
        .foregroundStyle(.white)
}


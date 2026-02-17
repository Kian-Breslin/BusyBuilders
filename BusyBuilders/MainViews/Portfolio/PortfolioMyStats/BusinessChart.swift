//
//  BusinessChart.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 17/02/2026.
//

import SwiftUI
import Charts
import SwiftData

struct BusinessChart: View {
    @Query var users: [UserDataModel]
    let businessNetWorth: Int
    let businessArray: [Double]
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(UserManager().mainColor)
            .frame(height: 200)
            .overlay {
                HStack (alignment: .top){
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Business Chart")
                            .font(.title3)
                            .underline()
                        Text("Total Net Worth: $\(businessNetWorth)")
                        if let user = users.first {
                            Text("Total Companies: \(user.businesses?.count ?? 0 )")
                            if let businesses = user.businesses {
                                if let bestBusiness = businesses.max(by: { $0.netWorth < $1.netWorth }) {
                                    Text("Best Company: \(bestBusiness.businessName)")
                                }
                                if let worstBusiness = businesses.min(by: { $0.netWorth < $1.netWorth }) {
                                    Text("Worst Company: \(worstBusiness.businessName)")
                                }
                            }
                        }
//                        Text("Top Company: WayLine")
//                        Text("Worst Company: ForgeYard")
//                        Text("Highest Level: Eco-Tech")
//                        Text("Newest Company: ForgeYard")
//                        Text("Avg Daily Income: $34,00")
//                        Text("Avg Weekly Income: $240,800")
                        
                    }
                    .font(.caption2)
                    Spacer()
                    BusinessChartPie(businessNetWorth: businessNetWorth, businessArray: businessArray)
                }
                .foregroundStyle(UserManager().textColor)
                .padding(10)
            }
    }
}

struct BusinessChartPie: View {
    let businessNetWorth: Int
    let businessArray: [Double]
    private var slices: [(id: Int, label: String, value: Double)] {
        businessArray.enumerated().map { (index, value) in (id: index, label: "Slice \(index + 1)", value: value) }
    }
    var body: some View {
        Chart(slices, id: \.id) { slice in
            SectorMark(
                angle: .value("Value", slice.value)
            )
            .foregroundStyle(by: .value("Label", slice.label))
        }
        .chartLegend(.hidden)
        .frame(width: 190, height: 190)
        .overlay {
            Circle()
                .fill(UserManager().mainColor)
                .frame(width: 165, height: 165)
                .overlay {
                    VStack {
                        Text("Total Net Worth")
                            .font(.caption)
                            .underline()
                        Text("$\(businessNetWorth)")
                            .font(.title2)
                    }
                }
        }
    }
}

#Preview {
    BusinessChart(businessNetWorth: 53654, businessArray: [0.40, 0.30, 0.20, 0.10, 0.3])
        .padding(10)
}

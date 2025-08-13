//
//  PlayStocks.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 04/08/2025.
//

import SwiftUI
import SwiftData

struct Stock: Identifiable, Codable {
    let id: String
    let name: String?
    let price: Double?
    let change: String?
    let percentChange: String?
    let lastUpdated: String?
    let averageChange: String?  // Add this
}

struct StockResponse: Codable {
    let stocks: [Stock]
}

class StocksViewModel: ObservableObject {
    @Published var stocks: [Stock] = []
    @Published var errorMessage: String?

    func fetchStocks() {
        guard let url = URL(string: "https://www.busybuilders.app/.netlify/functions/getStocksData") else {
            self.errorMessage = "Invalid URL"
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                guard let data = data else {
                    self.errorMessage = "No data received"
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode(StockResponse.self, from: data)
                    self.stocks = decoded.stocks
                } catch {
                    self.errorMessage = "Decoding failed: \(error)"
                }
            }
        }.resume()
    }
}

struct PlayStocks: View {
    @EnvironmentObject var userManager: UserManager
    @StateObject private var viewModel = StocksViewModel()
    @State var selectedStock: Stock?

    var body: some View {
        ScrollView {
            if let error = viewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
                    .padding()
            } else {
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(viewModel.stocks) { stock in
                        StockCardView(stock: stock)
                            .environmentObject(userManager)
                            .onTapGesture {
                                selectedStock = stock
                            }
                    }
                }
                .padding(.bottom, 75)
            }
        }
        .scrollIndicators(.hidden)
        .padding(.top, 15)
        .frame(width: screenWidth, height: screenHeight-240)
        .background(userManager.secondaryColor)
        .foregroundStyle(userManager.mainColor)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .onAppear {
            viewModel.fetchStocks()
        }
        .sheet(item: $selectedStock) { stock in
            PlayStocksBuySheet(stock: stock)
                .presentationDetents([.fraction(0.4)])
        }
    }
}

struct StockCardView: View {
    @Query var users: [UserDataModel]
    let stock: Stock
    @EnvironmentObject var userManager: UserManager

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(stock.name ?? "Stock wasn't found")
                .font(.title3)
                .bold()
                .foregroundColor(.white)

            if let price = stock.price {
                let costToBuy = Int(ceil(price))
                let tax = Double(costToBuy) - price
                
                Text("Price: $\(String(format: "%.2f", price))")
                    .font(.system(.body, design: .monospaced))
                    .foregroundColor(.white)
                
            } else {
                Text("Price: N/A")
                    .font(.system(.body, design: .monospaced))
                    .foregroundColor(.white)
            }

            if let avgChangeStr = stock.averageChange, let avgChange = Double(avgChangeStr) {
                Text("Avg Change (last 10): \(String(format: "%.2f", avgChange))%")
                    .font(.system(.body, design: .monospaced))
                    .foregroundColor(avgChange >= 0 ? .green : .red)
            } else {
                Text("Avg Change (last 10): N/A")
                    .font(.system(.body, design: .monospaced))
                    .foregroundColor(.white)
            }
        }
        .padding()
        .frame(width: screenWidth-20, height: 130, alignment: .leading)
        .background(userManager.mainColor)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
//        .onTapGesture {
//            print("\(stock.name ?? "No Name")")
//            print("$\(stock.price ?? 0.0)")
//
//            if let user = users.first, let stockPrice = stock.price {
//                let costToBuy = Int(ceil(stockPrice))
//                if user.availableBalance >= costToBuy {
//                    user.availableBalance -= costToBuy
//                    print("User bought \(stock.name ?? "stock") at cost $\(costToBuy) (tax applied: $\(String(format: "%.2f", Double(costToBuy) - stockPrice)))")
//                } else {
//                    print("Insufficient funds to buy \(stock.name ?? "stock")")
//                }
//            }
//        }
    }
}

// Helper function for date formatting
func formattedDate(from lastUpdated: String?) -> String {
    guard let isoString = lastUpdated,
          let date = ISO8601DateFormatter().date(from: isoString) else {
        return "N/A"
    }
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter.string(from: date)
}

#Preview {
    Play(selectedIcon: "circle")
        .environmentObject(UserManager())
}

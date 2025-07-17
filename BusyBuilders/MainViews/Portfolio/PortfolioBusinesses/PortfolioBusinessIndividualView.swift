import SwiftUI
import SwiftData

struct PortfolioBusinessIndividualView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userManager: UserManager
    let business: BusinessDataModel
    
    @State var hiringDptNotOwnedAlert = false

    var body: some View {
        ZStack {
            userManager.mainColor.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Label("Back", systemImage: "chevron.left")
                        .foregroundStyle(getColor(business.businessTheme))
                        .onTapGesture {
                            dismiss()
                        }
                    
                    Label(business.businessName, systemImage: business.businessIcon)
                        .font(.title)
                        .bold()

                    VStack(alignment: .leading, spacing: 10) {
                        InfoItem(text: "Level", info: "\(business.level)")
                        HStack {
                            InfoItem(text: "CPM", info: "$\(business.cashPerMinute)")
                            InfoItem(text: "Cost/Min", info: "$\(business.costPerMinute)")
                        }
                        InfoItem(text: "Business Type", info: business.businessType.capitalized)
                        HStack {
                            InfoItem(text: "Employees", info: "\(business.employees)")
                            Spacer()
                            Image(systemName: "cart")
                                .onTapGesture {
                                    print("Buy Employee")
                                    if business.departments["Hiring Department"] == true {
                                        business.employees += 1
                                    } else {
                                        hiringDptNotOwnedAlert.toggle()
                                    }
                                }
                        }
                        InfoItem(text: "Building", info: business.building.isEmpty ? "None" : business.building)
                    }
                    .foregroundColor(userManager.textColor)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Departments")
                            .font(.headline)
                            .foregroundColor(userManager.textColor)

                        ForEach(business.departments.sorted(by: { $0.key < $1.key }), id: \.key) { dept, isUnlocked in
                            HStack {
                                Image(systemName: isUnlocked ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(isUnlocked ? .green : .gray)
                                Text(dept)
                                    .foregroundColor(userManager.textColor)
                                Spacer()
                                Image(systemName: isUnlocked ? "" : "cart")
                                    .onTapGesture {
                                        if !isUnlocked {
                                            business.departments[dept] = true
                                        }
                                    }
                            }
                        }
                    }

                    Spacer()
                }
                .foregroundStyle(userManager.textColor)
                .frame(maxWidth: screenWidth - 20, alignment: .leading)
            }
        }
        .alert("Department Locked", isPresented: $hiringDptNotOwnedAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("You need to unlock the Hiring Department before you can hire employees.")
        }
    }
}
struct InfoItem: View {
    let text: String
    let info: String
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(text)
                .font(.subheadline)
            Text(info)
                .font(.headline)
        }
    }
}

#Preview {
    PortfolioBusinessIndividualView(business: BusinessDataModel.previewBusiness)
        .environmentObject(UserManager())
}

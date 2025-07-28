import SwiftUI
import SwiftData

struct PortfolioBusinessIndividualView: View {
    @Query var users: [UserDataModel]
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userManager: UserManager
    let business: BusinessDataModel
    
    @State var hiringDptNotOwnedAlert = false
    @State private var selectedDepartment: String = "none"
    @State var showDepartment = false
    

    var body: some View {
        NavigationView {
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

                        InfoItemView(business: business)
                            .foregroundColor(userManager.textColor)

                        DepartmentHolderView(business: business, showDepartments: $showDepartment)

                        Spacer()
                    }
                    .foregroundStyle(userManager.textColor)
                    .frame(maxWidth: screenWidth - 20, alignment: .leading)
                }
                .scrollIndicators(.hidden)
            }
            .alert("Department Locked", isPresented: $hiringDptNotOwnedAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("You need to unlock the Hiring Department before you can hire employees.")
            }
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
struct InfoItemView: View {
    let business: BusinessDataModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            InfoItem(text: "Level", info: "\(business.level)")
            HStack {
                InfoItem(text: "CPM", info: "$\(business.cashPerMinute)")
                InfoItem(text: "Cost/Min", info: "$\(business.costPerMinute)")
            }
            InfoItem(text: "Business Type", info: business.businessType.capitalized)
            ExtractedView(business: business)
        }
    }
}
struct ExtractedView: View {
    let business: BusinessDataModel
    @State var showBuilding = true
    @State var chosenCategory = "Owned"
    let buildingsArray = buildings
    var buildingsToDisplay: [Building] {
        switch chosenCategory {
        case "Owned":
            return business.buildings
        case "Rented":
            return business.rentedBuildings
        case "Renting":
            return business.rentingBuildings
        case "Buy":
            return buildingsArray
        default:
            return business.buildings
        }
    }
    @State var alreadyOwnedError = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Buildings")
                    .font(.headline)
                Spacer()
                Group{
                    Text("\(showBuilding ? "Hide" : "Show")")
                        .font(.caption)
                    Image(systemName: "\(showBuilding ? "chevron.down" : "chevron.right")")
                        .font(.caption)
                }
                .onTapGesture {
                    withAnimation(.snappy(duration: 0.3)){
                        showBuilding.toggle()
                    }
                }
            }
            if showBuilding {
                Picker("Category", selection: $chosenCategory) {
                    Text("Owned").tag("Owned")
                    Text("Rented").tag("Rented")
                    Text("Renting").tag("Renting")
                    Text("Buy").tag("Buy")
                }
                .pickerStyle(.segmented)
                .animation(.linear, value: chosenCategory)
                .transition(.move(edge: .bottom).combined(with: .opacity))
                
                ForEach(buildingsToDisplay, id: \.self) { building in
                    BuildingView(business: business, buildings: building)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .opacity(business.buildings.contains(where: { $0.name == building.name }) && chosenCategory == "Buy" ? 0.3 : 1)
                        .onTapGesture {
                            if chosenCategory == "Buy" {
                                let ownershipStatus = business.checkBuildingOwnership(buildingName: building.name)
                                if !ownershipStatus.0 {
                                    business.buildings.append(building)
                                    chosenCategory = "Owned"
                                } else {
                                    alreadyOwnedError.toggle()
                                }
                            }
                        }
                        .alert("Already Owned", isPresented: $alreadyOwnedError) {
                            Button("OK", role: .cancel) {}
                        } message: {
                            Text("\(business.checkBuildingOwnership(buildingName: building.name).1)")
                        }
                }
            }
        }
    }
}
struct BuildingView: View {
    let business : BusinessDataModel
    let buildings : Building
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: screenWidth-20, height: 100)
            .foregroundStyle(UserManager().textColor.opacity(0.3))
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(getColor(business.businessTheme), lineWidth: 2)
                    .frame(width: screenWidth-22, height: 98)
                    .overlay {
                        HStack {
                            VStack (alignment: .leading){
                                Text("\(buildings.name)")
                                    .font(.headline)
                                Label("$\(buildings.boostPerSession)", systemImage: "plus.square")
                                Label("$\(buildings.costPerSession)", systemImage: "minus.square")
                                Label("$\(buildings.cost)", systemImage: "dollarsign.square")
                                Spacer()
                            }
                            .font(.caption)
                            Spacer()
                            Image("\(buildings.image)")
                                .resizable()
                                .frame(width: 80, height: 80)
                        }
                        .frame(width: screenWidth-40, height: 80)
                    }
            }
    }
}
struct DepartmentItem: View {
    let user : UserDataModel?
    @Binding var selectedDept : String
    let dept : String
    let business: BusinessDataModel
    @State var showProductLaunchScreen = false
    
    @State var isErrorBuying = false
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: (screenWidth-20), height: selectedDept == dept ? 250 : 50)
            .foregroundStyle(UserManager().secondaryColor)
            .overlay {
                VStack (alignment: .leading){
                    HStack {
                        Text("\(dept.capitalized)")
                        Spacer()
                        if business.departments[dept]?.isUnlocked == true {
                            Label("\(business.departments[dept]?.level ?? 0)",  systemImage: "star.fill")
                                .transition(.scale)
                        } else {
                            Label("$\(business.priceForNewDepartment())", systemImage: "cart.fill.badge.plus")
                                .onTapGesture {
                                    withAnimation(.bouncy){
                                        if let user {
                                            if user.availableBalance >= business.priceForNewDepartment(){
                                                business.buyDepartment(dept: dept)
                                            } else {
                                                isErrorBuying.toggle()
                                            }
                                        }
                                    }
                                }
                                .transition(.scale)
                        }
                    }
                    .frame(height: 20)
                    .padding(.top, 15)
                    
                    Spacer()
                    if selectedDept == dept {
                        switch selectedDept {
                        case "Finance Department":
                            FinanceDeptView(business: business)
                                .transition(.scale.combined(with: .opacity))
                        case "Hiring Department":
                            HiringDeptView(business: business)
                                .transition(.scale.combined(with: .opacity))
                        case "Marketing Department":
                            MarketingDeptView(business: business)
                                .transition(.scale.combined(with: .opacity))
                        case "Operations Department":
                            OperationsDeptView(business: business)
                                .transition(.scale.combined(with: .opacity))
                        case "Research and Development Department":
                            ResearchDeptView(business: business, showProductLaunchScreen: $showProductLaunchScreen)
                                .transition(.scale.combined(with: .opacity))
                        default:
                            Text("Not Found")
                        }
                    }
                    
                }
                .frame(width: screenWidth-40, alignment: .topLeading)
            }
            .alert("Not Enough Cash", isPresented: $isErrorBuying) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("You do not have enough cash to buy a \(dept.capitalized), Start a session to earn some cash")
            }
            .fullScreenCover(isPresented: $showProductLaunchScreen) {
                ProductLaunch(business: business)
            }
    }
}

private func getDeptIcon(deptName: String) -> String {
    switch deptName {
    case "Finance Department":
        "dollarsign"
    case "Hiring Department":
        "person.2"
    case "Marketing Department":
        "speaker.wave.3"
    case "Operations Department":
        "car"
    case "Research and Development Department":
        "magnifyingglass"
    default:
        "person"
    }
}


#Preview {
    PortfolioBusinessIndividualView(business: BusinessDataModel.previewBusiness)
        .environmentObject(UserManager())
}



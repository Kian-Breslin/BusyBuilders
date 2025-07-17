//
//  PortfolioCreateBusiness.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 17/07/2025.
//

import SwiftUI
import SwiftData

struct PortfolioCreateBusiness: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userManager: UserManager
    @Query var users : [UserDataModel]
    
    @State var name : String = ""
    @State var theme: String = "red"
    @State var type: String = "eco"
    @State var icon: String = "building.2"
    @State private var isSigned: Bool = false
    
    var body: some View {
        ZStack {
            userManager.mainColor.ignoresSafeArea()
            
            VStack (alignment: .leading, spacing: 20){
                Label("Back", systemImage: "chevron.left")
                    .foregroundStyle(getColor(userManager.accentColor))
                    .onTapGesture {
                        dismiss()
                    }
                
                Text("Open a Business")
                    .font(.title)
                
                
                VStack (alignment: .leading, spacing: 20){
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Business Name")
                            .font(.caption)
                            .foregroundColor(.white)

                        TextField("", text: $name, prompt: Text("Name").foregroundColor(.gray).font(.title))
                        .padding(.vertical, 5)
                    }
                    
                    ThemePickerView(theme: $theme)
                    BusinessTypePickerView(type: $type)
                    BusinessIconPickerView(icon: $icon)
                            
                    
                }
                
                Spacer()
                
                if !isSigned {
                    Button(action: {
                        withAnimation {
                            isSigned = true
                        }
                        print("Created")
                        if let user = users.first {
                            user.OpenBusiness(name: name, theme: theme, type: type, icon: icon)
                            do {
                                 try context.save()
                            }
                            catch {
                                print("Couldnt Save business")
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            dismiss()
                        }
                    }) {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(userManager.textColor, lineWidth: 2)
                            .frame(width: screenWidth-20, height: 50)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: screenWidth-20, height: 50)
                                    .opacity(0.1)
                                    .overlay {
                                        Text("Sign Contract")
                                            .font(.title2)
                                    }
                            }
                    }
                    .padding(.bottom, 20)
                } else {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(getColor(theme))
                        .frame(width: screenWidth-20, height: 50)
                        .overlay(
                            HStack {
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundColor(.white)
                                Text("Created")
                                    .foregroundColor(.white)
                                    .font(.title2)
                            }
                        )
                        .padding(.bottom, 20)
                }
            }
            .foregroundStyle(userManager.textColor)
            .frame(width: screenWidth-20, alignment: .leading)
        }
    }
}

struct ThemePickerView: View {
    @Binding var theme: String
    let themeColors = ["red", "green", "blue", "pink", "purple", "yellow"]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Business Theme")
                .font(.caption)

            HStack(spacing: 12) {
                ForEach(themeColors, id: \.self) { themeColor in
                    ZStack{
                        RoundedRectangle(cornerRadius: 8)
                            .fill(getColor(themeColor))
                            .frame(width: theme == themeColor ? 60 : 40, height: 40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(theme == themeColor ? UserManager().textColor : .clear, lineWidth: 3)
                            )
                            .animation(.easeInOut(duration: 0.2), value: theme)

                        if theme == themeColor {
                            Text(themeColor.capitalized)
                                .font(.caption)
                                .foregroundColor(theme == "yellow" ? .black : .white)
                                .transition(.opacity)
                        }
                    }
                    .onTapGesture {
                        theme = themeColor
                    }
                }
            }
        }
    }
}
struct BusinessTypePickerView: View {
    @Binding var type: String

    let businessTypes: [(id: String, label: String, icon: String)] = [
        ("eco", "Eco-Friendly", "leaf"),
        ("balanced", "Balanced", "scalemass"),
        ("corporate", "Corporate", "building.2")
    ]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Business Type")
                .font(.caption)

            HStack(spacing: 12) {
                ForEach(businessTypes, id: \.id) { business in
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(type == business.id ? UserManager().textColor.opacity(0.1) : .clear)
                            .frame(width: type == business.id ? 120 : 40, height: 40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(type == business.id ? UserManager().textColor : .clear, lineWidth: 2)
                            )
                            .animation(.easeInOut(duration: 0.2), value: type)

                        HStack(spacing: 6) {
                            Image(systemName: business.icon)
                                .foregroundColor(UserManager().textColor)
                            if type == business.id {
                                Text(business.label)
                                    .foregroundColor(UserManager().textColor)
                                    .font(.caption)
                            }
                        }
                        .padding(.horizontal, 8)
                    }
                    .onTapGesture {
                        type = business.id
                    }
                }
            }
        }
    }
}
struct BusinessIconPickerView: View {
    @Binding var icon: String

    let iconOptions: [(id: String, label: String)] = [
        ("building.2", "Office"),
        ("house", "Home"),
        ("cart", "Shop"),
        ("leaf", "Eco"),
        ("wrench", "Repair"),
        ("briefcase", "Agency"),
        ("doc.text", "Docs"),
        ("globe", "Global"),
        ("shippingbox", "Logistics"),
        ("gear", "Factory")
    ]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Business Icon")
                .font(.caption)

            ScrollView (.horizontal){
                HStack(spacing: 0) {
                    ForEach(iconOptions, id: \.id) { item in
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(icon == item.id ? UserManager().textColor.opacity(0.1) : .clear)
                                .frame(width: icon == item.id ? 100 : 40, height: 40)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(icon == item.id ? UserManager().textColor : .clear, lineWidth: 2)
                                )
                                .animation(.easeInOut(duration: 0.2), value: icon)

                            HStack(spacing: 6) {
                                Image(systemName: item.id)
                                    .foregroundColor(UserManager().textColor)
                                if icon == item.id {
                                    Text(item.label)
                                        .foregroundColor(UserManager().textColor)
                                        .font(.caption)
                                }
                            }
                            .padding(.horizontal, 8)
                        }
                        .onTapGesture {
                            icon = item.id
                        }
                    }
                }
                .padding(.horizontal, 2)
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    PortfolioCreateBusiness()
        .environmentObject(UserManager())
}

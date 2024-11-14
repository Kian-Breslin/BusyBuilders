//
//  MyBusinesses.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 14/11/2024.
//

import SwiftUI
import SwiftData

struct MyBusinesses: View {
    
    @Query var users: [UserDataModel]
    @Query var businesses: [BusinessDataModel]
    @Environment(\.modelContext) var context
    @State var selectedBusinessToDelete : BusinessDataModel?
    @State var confirmDeleteBusiness = false
    @State var createNewBusiness = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 250, height: 150)
            .foregroundStyle(getColor("black"))
            .overlay {
                VStack {
                    Text("Confirm Deletion")
                        .bold()
                        .foregroundStyle(getColor("white"))
                    Spacer()
                    Text("Are you sure you want to delete \(selectedBusinessToDelete?.businessName ?? "Name")?")
                        .font(.system(size: 15))
                        .multilineTextAlignment(.center)
                   
                    Spacer()
                    HStack {
                        Text("Back")
                            .font(.system(size: 20))
                            .foregroundStyle(getColor("blue"))
                            .frame(width: 120)
                            .onTapGesture {
                                confirmDeleteBusiness.toggle()
                            }
                        Rectangle()
                            .frame(width: 2, height: 20)
                            .opacity(0.5)
                            .foregroundStyle(getColor("white"))
                        Text("Confirm")
                            .foregroundStyle(getColor("red"))
                            .font(.system(size: 20))
                            .frame(width: 120)
                            .onTapGesture {
                                print("Deleted: \(selectedBusinessToDelete!)")
                                context.delete(selectedBusinessToDelete!)
                                do {
                                    try context.save()
                                    confirmDeleteBusiness.toggle()
                                } catch {
                                    print("Error Deleting Business")
                                }
                            }
                    }
                }
                .padding()
                .foregroundStyle(getColor("white"))
            }
            .opacity(confirmDeleteBusiness ? 1 : 0)
            .zIndex(99)
        ScrollView {
            VStack {
                ForEach(businesses){ b in
                    NavigationLink(destination : BusinessNavigationDestination(business: b)){
                        BusinessListItem(business: b)
                            .onLongPressGesture(minimumDuration: 0.5) {
                                selectedBusinessToDelete = b
                                confirmDeleteBusiness.toggle()
                            }
                            .sensoryFeedback(.impact(flexibility: .soft, intensity: 50), trigger: confirmDeleteBusiness)
                    }
                }
            }
            RoundedRectangle(cornerRadius: 5)
                .frame(width: screenWidth-30, height: 100)
                .foregroundStyle(getColor("black"))
                .overlay {
                    Text("Click here to add a Business")
                        .opacity(0.7)
                        .font(.system(size: 25))
                }
                .onTapGesture {
                    createNewBusiness = true
                }
        }
        .blur(radius: confirmDeleteBusiness ? 5 : 0)
        .padding(.top, 15)
        .sheet(isPresented: $createNewBusiness) {
            CreateNewBusiness()
                .presentationDetents([.fraction(0.75)])
        }
    }
}

#Preview {
    MyBusinesses()
        .modelContainer(for: UserDataModel.self, inMemory: true)
}

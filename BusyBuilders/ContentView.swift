//
//  ContentView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 20/05/2024.
//

/*

 [Feature] : Adding a feature to the app
 
 [Bug] : Fixing Bugs
 
 [Clean] : Cleaning up code / Refactoring
 
*/


import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State private var isShowingBusinessAddSheet = false
    @State private var isShowingStartTaskSheet = false
    @State private var isShowingBusinessShowSheet = false
    @State private var showAlert = false
    @State var theSelectedView = 0
    @State var theMakeNewBusiness = false
    @Query var businesses : [BusinessDataModel]
    @Query var user : [UserDataModel]
    // Test UserName
    var usernameTester = "Kian Breslin"
    
    var body: some View {
        
        
        if(user.isEmpty == false) {
//            CreateUserData()
        } else {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                VStack {
                    if(theSelectedView == 0 || theSelectedView == 1 || theSelectedView == 2 ) {
//                        HomeView(username: "\(user[0].username)")
                        HomeView(username: "\(usernameTester)", totalRevenue: 1.5, bestPerfoming: "")
                    }
                    if(theSelectedView == 3) {
                        LeaderboardView()
                    }
                    if(theSelectedView == 4) {
                        ShowBusinesses()
                    }
                }
                .sheet(isPresented: $theMakeNewBusiness, content: {
                    CreateBusiness()
                })
                .sheet(isPresented: $isShowingStartTaskSheet, content: {
                    Color.red
                        .ignoresSafeArea()
                })
                
                VStack {
                    Spacer()
                    
                    NavigationBar(selectedView: $theSelectedView, makeNewBusiness: $theMakeNewBusiness, startTask: $isShowingStartTaskSheet)
                        .frame(width: 300)
                }
                .ignoresSafeArea()
            }
        }
        
        
    }
}


#Preview {
//    do {
//        let previewer = try Previewer()
//        
//        return ContentView()
//    } catch {
//        return Text("Failed to create preview : \(error.localizedDescription)")
//    }
    ContentView()
}

extension View {
    @available(iOS 14, *)
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
        return self
    }
}

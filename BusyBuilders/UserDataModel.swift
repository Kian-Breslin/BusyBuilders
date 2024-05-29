//
//  UserDataModel.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 28/05/2024.
//

import Foundation
import SwiftData

@Model
class UserDataModel : Identifiable{
    var username : String
    var userProfile : String
    var currentNumberOfBusinesses : Int?
    var totalRevenue : Int?
    
    init(username: String, userProfile: String, currentNumberOfBusinesses: Int, totalRevenue: Int) {
        self.username = username
        self.userProfile = userProfile
        self.currentNumberOfBusinesses = currentNumberOfBusinesses
        self.totalRevenue = totalRevenue
    }
}

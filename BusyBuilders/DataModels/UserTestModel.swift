//
//  UserTestModel.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 04/10/2024.
//

import Foundation
import SwiftData

@Model
class UserTestModel: Identifiable {
    var id : String
    var name : String
    
    init(id: String, name: String) {
        self.id = UUID().uuidString
        self.name = name
    }
}

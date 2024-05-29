//
//  MockBusinesses.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 28/05/2024.
//

import Foundation
import SwiftUI

struct MockBusinesses : Hashable {
    var businessName : String
    var businessIcon : String
    var businessDescription : String
    var businessTheme : Color

    init(businessName: String, businessIcon: String, businessDescription: String, businessTheme: Color) {
        self.businessName = businessName
        self.businessIcon = businessIcon
        self.businessDescription = businessDescription
        self.businessTheme = businessTheme
    }
}


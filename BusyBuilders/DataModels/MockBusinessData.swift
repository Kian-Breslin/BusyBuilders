//
//  MockBusinessData.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 29/05/2024.
//

import Foundation
import SwiftUI

class MockBusinessData: Identifiable{
    var businessName : String
    var businessIcon : String
    var businessTheme : Color
    
    init(businessName: String, businessIcon: String, businessTheme: Color) {
        self.businessName = businessName
        self.businessIcon = businessIcon
        self.businessTheme = businessTheme
    }
}

var businessMockFill: [MockBusinessData] = [
    MockBusinessData(businessName: "Business 1", businessIcon: "circle", businessTheme: .blue),
    MockBusinessData(businessName: "Business 2", businessIcon: "square", businessTheme: .red),
    MockBusinessData(businessName: "Business 3", businessIcon: "triangle", businessTheme: .orange),
    MockBusinessData(businessName: "Business 4", businessIcon: "star", businessTheme: .yellow),
    MockBusinessData(businessName: "Business 5", businessIcon: "diamond", businessTheme: .green),
    MockBusinessData(businessName: "Business 6", businessIcon: "hexagon", businessTheme: .purple),
    MockBusinessData(businessName: "Business 7", businessIcon: "heart", businessTheme: .pink),
    MockBusinessData(businessName: "Business 8", businessIcon: "pentagon", businessTheme: .cyan),
    MockBusinessData(businessName: "Business 9", businessIcon: "octagon", businessTheme: .teal),
    MockBusinessData(businessName: "Business 10", businessIcon: "cross", businessTheme: .gray)
]

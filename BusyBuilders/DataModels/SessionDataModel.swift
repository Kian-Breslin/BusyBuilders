//
//  SessionDataModel.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 05/10/2024.
//

import Foundation
import SwiftData
import SwiftUI

struct SessionDataModel: Identifiable, Codable, Hashable {
    var id: UUID
    var sessionDate: Date
    var businessId: UUID

    // Business stats
    var totalCashEarned: Int
    var totalCostIncurred: Int
    var totalXPEarned: Int
    var totalStudyTime: Int

    // Product stats
    var productsSnapshot: [ProductSellingSession]
}



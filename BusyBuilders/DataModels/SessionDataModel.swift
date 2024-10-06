//
//  SessionDataModel.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 05/10/2024.
//

import Foundation
import SwiftData

@Model
class SessionDataModel: Identifiable {
    var id: UUID // Unique identifier for each session
    var sessionStart: Date // Start time of the study session
    var sessionEnd: Date // End time of the study session
    var totalStudyTime: Int // Total time spent studying during the session
    var businessId: UUID // The ID of the business related to this session

    init(sessionStart: Date, sessionEnd: Date, totalStudyTime: Int, businessId: UUID) {
        self.id = UUID() // Automatically assign a new UUID
        self.sessionStart = sessionStart
        self.sessionEnd = sessionEnd
        self.totalStudyTime = totalStudyTime
        self.businessId = businessId // Reference to the related business
    }
}

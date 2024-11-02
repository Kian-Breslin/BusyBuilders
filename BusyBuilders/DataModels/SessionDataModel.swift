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
    var sessionDate: Date
    var sessionStart: String // Start time of the study session
    var sessionEnd: String // End time of the study session
    var totalStudyTime: Int // Total time spent studying during the session
    var businessId: UUID // The ID of the business related to this session

    init(id: UUID, sessionDate: Date, sessionStart: String, sessionEnd: String, totalStudyTime: Int, businessId: UUID) {
        self.id = UUID()
        self.sessionDate = sessionDate
        self.sessionStart = sessionStart
        self.sessionEnd = sessionEnd
        self.totalStudyTime = totalStudyTime
        self.businessId = businessId
    }
}

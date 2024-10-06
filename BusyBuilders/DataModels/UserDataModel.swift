////
////  UserModel.swift
////  BusyBuilders
////
////  Created by Kian Breslin on 04/10/2024.
////
import Foundation
import SwiftData

@Model
public class UserDataModel: Identifiable, ObservableObject {
    public var id: UUID // Unique identifier for the user
    var name: String // User's chosen username
    var email: String // User's email address
    var password: String
    var businesses: [BusinessDataModel] // List of businesses owned by the user

    // Initialize the UserDataModel with default values
    init(id: UUID = UUID(),
         name: String,
         email: String,
         password: String = "") {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.businesses = []
    }
}

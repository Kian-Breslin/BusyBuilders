//
//  ItemDataModel.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 17/07/2025.
//

import Foundation

struct ItemModel: Codable, Hashable {
    var name: String
    var owned: Bool
    var price: Int
    var imageName: String 
}

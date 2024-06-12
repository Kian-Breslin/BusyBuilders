//
//  PublicFunctions.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 29/05/2024.
//

import Foundation
import SwiftData
import SwiftUI

public func AddNumbers(_ num1 : Int, _ num2 : Int) -> String {
    let addedNums = num1 + num2
    
    return String(addedNums)
}


public func timeFormatted(_ totalSeconds: Int) -> String {
    let hours = totalSeconds / 3600
    let minutes = (totalSeconds % 3600) / 60
    let seconds = totalSeconds % 60
    return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
}

public func timeFormattedMins(_ totalSeconds: Int) -> String {
    let hours = totalSeconds / 3600
    let minutes = (totalSeconds % 3600) / 60
    
    return String(format: "%02d:%02d", hours, minutes)
}

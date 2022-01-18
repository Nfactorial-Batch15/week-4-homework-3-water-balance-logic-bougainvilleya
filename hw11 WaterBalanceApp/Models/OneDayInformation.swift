//
//  HistoryItem.swift
//  hw11 WaterBalanceApp
//
//  Created by Leyla Nyssanbayeva on 15.01.2022.
//

import SwiftUI

struct IntakeItem: Identifiable, Codable {
    var id = UUID()
    var time: Date
    var amount: Int
}

struct OneDayInformation: Identifiable, Codable {
    var id = UUID()
    var date: Date
    var intakeItems: [IntakeItem]
}

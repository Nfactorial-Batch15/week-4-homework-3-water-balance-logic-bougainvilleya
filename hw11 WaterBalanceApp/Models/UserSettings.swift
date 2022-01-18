//
//  UserSettings.swift
//  hw11 WaterBalanceApp
//
//  Created by Leyla Nyssanbayeva on 17.01.2022.
//

import SwiftUI

struct UserSettings: Codable {
    var total = "1000"
    var done = 0
    var oneCupOfWater = "200"
    var selectedGoal: [Bool] = [true, false, false, false]
    var selectedTime = 1.0
    var oneDayInformations: [OneDayInformation] = []
    var isOnboarding = true
}


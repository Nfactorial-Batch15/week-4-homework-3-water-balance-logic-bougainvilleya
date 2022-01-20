//
//  CurrentDateTime.swift
//  hw11 WaterBalanceApp
//
//  Created by Leyla Nyssanbayeva on 14.01.2022.
//

import SwiftUI

struct CurrentDateTime {
    var currentDate = Date()
    var weekDay = "Monday"
    var day = "1"
    var month = "1"
    var ordinal = "st"
    
    mutating func updateDateTime() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        month = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "EEEE"
        weekDay = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "dd"
        day = dateFormatter.string(from: date)

        switch day.last! {
        case "1":
            ordinal = "st"
        case "2":
            ordinal = "nd"
        case "3":
            ordinal = "rd"
        default:
            ordinal = "th"
        }
        currentDate = date
    }
}

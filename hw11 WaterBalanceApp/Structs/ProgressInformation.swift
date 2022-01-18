//
//  ProgressInformation.swift
//  hw11 WaterBalanceApp
//
//  Created by Leyla Nyssanbayeva on 14.01.2022.
//

import SwiftUI

struct ProgressInformation: View {
    @Binding var userSettings: UserSettings
    
    var body: some View {
        VStack {
            Text(String(format: "%.1f%%", calculatePercent()))
                .font(Font.system(size: 36, weight: .semibold))
            
            let s = String(format: "%.1f", Double(userSettings.done) / 1000.0)
            let s1 = String(format: "%.1f", totalNum() / 1000.0)
            
            Text("\(s) out of \(s1) L")
                .font(Font.system(size: 16, weight: .light))
        }
    }
    
    func calculatePercent() -> Double {
        let div = (Double(userSettings.done) * 100 / totalNum()).rounded()
        return min(div, 100)
    }
    
    func totalNum() -> Double {
        let totalNum = Double(userSettings.total) ?? 1
        return totalNum == 0 ? 1 : totalNum
    }
    
}

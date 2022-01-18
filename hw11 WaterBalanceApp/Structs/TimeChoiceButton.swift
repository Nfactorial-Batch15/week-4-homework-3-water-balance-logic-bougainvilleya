//
//  TimeChoiceButton.swift
//  hw11 WaterBalanceApp
//
//  Created by Leyla Nyssanbayeva on 11.01.2022.
//

import SwiftUI

struct TimeChoiseButton: View{
    var title: String = ""
    var buttonsValue: Double
    @Binding var selectedTime: Double
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .frame(height: 60)
                .foregroundColor(.white)
                .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(MyColor.electricBlue, lineWidth: buttonsValue == selectedTime ? 4 : 0)
                    )
            
            HStack{
                Text(title)
                    .foregroundColor(.black)
                    .font(Font.system(size: 16, weight: .semibold))
            }
            .padding(.horizontal, 24)
        }
    }
}


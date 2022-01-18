//
//  GoalChoiceButton.swift
//  hw11 WaterBalanceApp
//
//  Created by Leyla Nyssanbayeva on 11.01.2022.
//

import SwiftUI

struct GoalChoiceButton: View{
    @Binding var isSelected: Bool
    var title: String = ""
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .frame(height: 60)
                .foregroundColor(.white)
                .padding(.horizontal, 19)
            
            HStack{
                Text(title)
                    .foregroundColor(.black)
                    .font(Font.system(size: 16, weight: .medium))
                    
                Spacer()
                Image(systemName: isSelected ? "circle.circle.fill" : "circle.circle")
                    .foregroundColor(MyColor.electricBlue)
            }
            .padding(.horizontal, 43)
        }
    }
}

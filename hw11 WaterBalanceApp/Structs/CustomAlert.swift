//
//  CustomAlert.swift
//  hw11 WaterBalanceApp
//
//  Created by Leyla Nyssanbayeva on 18.01.2022.
//

import SwiftUI

struct CustomAlert: View {
    @Binding var isHidden: Bool
    
    var body: some View {
        withAnimation(.easeIn(duration: 2)) {
            ZStack{
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 156, height: 158)
                    .foregroundColor(MyColor.systemGray)
                
                Image(systemName: ("checkmark.circle"))
                    .foregroundColor(.white)
                    .font(Font.system(size: 56, weight: .thin))
            }
            .opacity(isHidden ? 0 : 0.6)
        }
    }
}

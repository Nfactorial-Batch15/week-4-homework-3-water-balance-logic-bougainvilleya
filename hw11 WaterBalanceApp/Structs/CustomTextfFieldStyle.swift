//
//  CustomTextfieldStyle.swift
//  hw11 WaterBalanceApp
//
//  Created by Leyla Nyssanbayeva on 15.01.2022.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(.white)
                    .frame(height: 60)
            )
    }
}

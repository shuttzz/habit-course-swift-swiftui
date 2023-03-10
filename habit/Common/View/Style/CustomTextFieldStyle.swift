//
//  CustomTextFieldStyle.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 06/03/23.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .overlay(
                RoundedRectangle(cornerRadius: 8.0)
                    .stroke(Color.orange, lineWidth: 0.8)
            )
    }
    
}

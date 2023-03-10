//
//  EditTextView.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 06/03/23.
//

import SwiftUI

struct EditTextView: View {
    
    @Binding var text: String
    
    var placeholder: String = ""
    var keyboard: UIKeyboardType = .default
    var error: String? = nil
    var failure: Bool? = nil
    var isSecure: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if isSecure {
                SecureField(placeholder, text: $text)
                    .foregroundColor(Color("textColor"))
                    .keyboardType(keyboard)
                    .textFieldStyle(CustomTextFieldStyle())
            } else {
                TextField(placeholder, text: $text)
                    .foregroundColor(Color("textColor"))
                    .keyboardType(keyboard)
                    .textFieldStyle(CustomTextFieldStyle())
            }
            
            if let error = error, failure == true, !text.isEmpty {
                Text(error)
                    .foregroundColor(.red)
                    .padding(.leading, 8)
            }
        }
        .padding(.bottom, 10)
    }
    
}

struct EditTextView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { value in
            VStack {
                EditTextView(
                    text: .constant("Texto"),
                    placeholder: "E-mail",
                    error: "Campo inválido",
                    failure: "a@a.com".count < 3)
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .preferredColorScheme(value)
        }
    }
}

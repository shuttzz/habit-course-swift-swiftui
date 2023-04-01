//
//  GenderSelectorView.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 15/03/23.
//

import SwiftUI

struct GenderSelectorView: View {
    
    @Binding var selectedGender: Gender?
    
    let genders: [Gender]
    let title: String
    
    var body: some View {
        
        Form {
            
            Section(header: Text(title)) {
                
                List(genders, id: \.id) {item in
                    
                    HStack {
                        
                        Text(item.rawValue)
                        Spacer()
                        Image(systemName: "checkmark")
                            .foregroundColor(selectedGender == item ? .orange : .white)
                        
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        
                        if !(selectedGender == item) {
                            selectedGender = item
                        }
                        
                    }
                    
                }
                
            }
            
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
        
    }
}

struct GenderSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        GenderSelectorView(selectedGender: .constant(nil), genders: Gender.allCases, title: "Teste")
    }
}

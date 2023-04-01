//
//  Date+Extension.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 14/03/23.
//

import Foundation

extension Date {
    
    func toString(destPattern dest: String) -> String {
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = dest
        
        return formatter.string(from: self)
        
    }
    
}

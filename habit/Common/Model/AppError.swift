//
//  AppError.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 11/03/23.
//

import Foundation

enum AppError: Error {
    
case response(message: String)
    
    public var message: String {
        
        switch self {
            case .response(let message):
                return message
        }
        
    }
    
}

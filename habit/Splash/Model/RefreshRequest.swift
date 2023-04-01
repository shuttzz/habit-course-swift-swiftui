//
//  RefreshRequest.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 13/03/23.
//

import Foundation

struct RefreshRequest: Encodable {
    
    let token: String
    
    enum CodingKeys: String, CodingKey {
        
        case token = "refresh_token"
        
    }
    
}

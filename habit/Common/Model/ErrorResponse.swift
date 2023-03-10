//
//  ErrorResponse.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 09/03/23.
//

import Foundation

struct ErrorResponse: Decodable {
    
    let detail: String
    
    // Esse CodingKey no Enum serve para dizer ao Swift que essa é a chave do json que será gerado
    enum CodingKeys: String, CodingKey {
        case detail
    }
    
}

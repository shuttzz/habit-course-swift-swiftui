//
//  SignUpRequest.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 08/03/23.
//

import Foundation

// Utilizamos o Encodable para dizer que esse objeto irá se transformar em um JSON
struct SignUpRequest: Encodable {
    
    let fullName: String
    let email: String
    let password: String
    let document: String
    let phone: String
    let birthday: String
    let gender: Int
    
    // Esse CodingKey no Enum serve para dizer ao Swift que essa é a chave do json que será gerado
    enum CodingKeys: String, CodingKey {
        case fullName = "name"
        case email
        case password
        case document
        case phone
        case birthday
        case gender
    }
    
}

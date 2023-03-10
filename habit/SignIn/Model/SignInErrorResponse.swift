//
//  SignInErrorResponse.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 09/03/23.
//

import Foundation

struct SignInErrorResponse: Decodable {

    let detail: SignInDetailErrorResponse

    enum CodingKeys: String, CodingKey {
        case detail
    }

}

struct SignInDetailErrorResponse: Decodable {

    let message: String

    enum CodingKeys: String, CodingKey {
        case message
    }

}

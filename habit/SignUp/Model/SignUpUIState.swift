//
//  SignUpUIState.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 05/03/23.
//

import Foundation

enum SignUpUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
}

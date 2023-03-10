//
//  SignInUIState.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 04/03/23.
//

import Foundation

enum SignInUIState: Equatable {
    case none
    case loading
    case goToHomeScreen
    case error(String)
}

//
//  HabitDetailUIState.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 14/03/23.
//

import Foundation

enum HabitDetailUIState: Equatable {
    
    case none
    case loading
    case success
    case error(String)
    
}

//
//  HabitUIState.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 13/03/23.
//

import Foundation

enum HabitUIState: Equatable {
    
    case loading
    case emptyList
    case fullList([HabitCardViewModel])
    case error(String)
    
}

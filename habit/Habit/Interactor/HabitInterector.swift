//
//  HabitInterector.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 14/03/23.
//

import Foundation
import Combine

class HabitInterector {
    
    private let remote: HabitRemoteDataSource = .shared
    
}

extension HabitInterector {
    
    func fetchHabits() -> Future<[HabitResponse], AppError> {
        
        return remote.fetchHabits()
        
    }
    
}

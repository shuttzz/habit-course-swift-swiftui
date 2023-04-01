//
//  HabitDetailInteractor.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 15/03/23.
//

import Foundation
import Combine

class HabitDetailInteractor {
    
    private let remote: HabitDetailRemoteDataSource = .shared
    
}

extension HabitDetailInteractor {
    
    func save(habitId: Int, habitValueRequest request: HabitValueRequest) -> Future<Bool, AppError> {
        
        return remote.save(habitId: habitId, request: request)
        
    }
    
}

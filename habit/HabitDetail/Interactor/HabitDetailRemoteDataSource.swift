//
//  HabitDetailRemoteDataSource.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 15/03/23.
//

import Foundation
import Combine

/**
 Essa classe será no padrão Singleton
 */
class HabitDetailRemoteDataSource {
    
    static var shared: HabitDetailRemoteDataSource = HabitDetailRemoteDataSource()
    
    private init() {}
    
    func save(habitId: Int, request: HabitValueRequest) -> Future<Bool, AppError> {
        
        return Future<Bool, AppError> { promise in
            
            let path = String(format: WebService.Endpoint.habitValues.rawValue, habitId)
            
            WebService.call(
                path: path,
                method: .post,
                body: request
            ) { result in
                
                switch result {
                    case .success(_):
                        
                        promise(.success(true))
                        
                        break
                    case .failure(_, let data):
                        if let data = data {
                            let decoder = JSONDecoder()
                            let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                            promise(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido no servidor")))
                        }
                        break
                }
                
            }
            
        }
        
    }
    
}

//
//  SplashRemoteDataSource.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 13/03/23.
//

import Foundation
import Combine

class SplashRemoteDataSource {
    
    static var shared: SplashRemoteDataSource = SplashRemoteDataSource()
    
    private init() {}
    
    func refreshToken(request: RefreshRequest) -> Future<SignInResponse, AppError> {
        
        return Future<SignInResponse, AppError> { promise in
            
            WebService.call(
                path: .refreshToken,
                method: .put,
                body: request
            ) { result in
                
                switch result {
                    case .success(let data):
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(SignInResponse.self, from: data)
                        
                        guard let response = response else {
                            print("Log: Error parser \(String(data: data, encoding: .utf8)!)")
                            return
                        }
                        
                        promise(.success(response))
                        
                        break
                    case .failure(let error, let data):
                        if let data = data {
                            if error == .unauthorized {
                                let decoder = JSONDecoder()
                                let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                                promise(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido no servidor")))
                                //completion(nil, response)
                            }
                        }
                        break
                }
                
            }
            
        }
        
    }
    
}

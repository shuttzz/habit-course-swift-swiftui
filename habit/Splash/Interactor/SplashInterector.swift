//
//  SplashInterector.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 13/03/23.
//

import Foundation
import Combine

class SplashInterector {
    
    private let remote: SplashRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
}

extension SplashInterector {
    
    func fetchAuth() -> Future<UserAuth?, Never> {
        
        return local.getUserAuth()
        
    }
    
    func inserAuth(userAuth: UserAuth) {
        local.insertUserAuth(userAuth: userAuth)
    }
    
    func refreshToken(refreshRequest request: RefreshRequest) -> Future<SignInResponse, AppError> {
        
        return remote.refreshToken(request: request)
        
    }
    
}

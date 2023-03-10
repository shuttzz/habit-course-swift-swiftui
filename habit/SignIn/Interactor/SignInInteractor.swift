//
//  SignInInteractor.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 10/03/23.
//

import Foundation

class SignInInteractor {
    
    private let remote: RemoteDataSource = .shared
    // private let local: LocalDataSource
    
}

extension SignInInteractor {
    
    func login(loginRequest request: SignInRequest, completion: @escaping (SignInResponse?, SignInErrorResponse?) -> Void) {
        
        remote.login(request: request, completion: completion)
        
    }
    
}

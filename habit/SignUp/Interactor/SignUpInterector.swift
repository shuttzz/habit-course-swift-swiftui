//
//  SignUpInterector.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 12/03/23.
//

import Foundation
import Combine

class SignUpInteractor {
    
    private let remoteSignUp: SignUpRemoteDataSource = .shared
    private let remoteSignIn: SignInRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
}

extension SignUpInteractor {
    
    func postUser(singUpRequest request: SignUpRequest) -> Future<Bool, AppError> {
        
        return remoteSignUp.postUser(request: request)
        
    }
    
    func login(singInRequest request: SignInRequest) -> Future<SignInResponse, AppError> {
        
        return remoteSignIn.login(request: request)
        
    }
    
    func insertAuth(userAuth: UserAuth) {
        local.insertUserAuth(userAuth: userAuth)
    }
    
}

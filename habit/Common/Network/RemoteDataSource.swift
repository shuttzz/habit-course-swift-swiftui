//
//  RemoteDataSource.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 10/03/23.
//

import Foundation

/**
    Essa classe será no padrão Singleton
 */
class RemoteDataSource {
    
    static var shared: RemoteDataSource = RemoteDataSource()
    
    private init() {}
    
    func login(request: SignInRequest, completion: @escaping (SignInResponse?, SignInErrorResponse?) -> Void) {
        
        WebService.call(
            path: .login,
            params: [
                URLQueryItem(name: "username", value: request.email),
                URLQueryItem(name: "password", value: request.password)
            ]
        ) { result in
            
            switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(SignInResponse.self, from: data)
                    completion(response, nil)
                    print(String(data: data, encoding: .utf8))
                    break
                case .failure(let error, let data):
                    if let data = data {
                        if error == .unauthorized {
                            let decoder = JSONDecoder()
                            let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                            completion(nil, response)
                        }
                    }
                    break
            }
            
        }
        
    }
    
}

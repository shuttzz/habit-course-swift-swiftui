//
//  SignUpViewModel.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 05/03/23.
//

import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var document = ""
    @Published var phone = ""
    @Published var birthday = ""
    @Published var gender = Gender.male
    
    var publisher: PassthroughSubject<Bool, Never>!
    
    @Published var uiState: SignUpUIState = .none
    
    func signUp() {
        self.uiState = .loading
        
        // Pegar a String -> dd/MM/yyyy -> Date
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormatted = formatter.date(from: birthday)
        
        // Validar a Data
        guard let dateFormatted = dateFormatted else {
            self.uiState = .error("Data inválida \(birthday)")
            return
        }
        
        // Date -> yyyy-MM-dd -> String
        formatter.dateFormat = "yyyy-MM-dd"
        let birthday = formatter.string(from: dateFormatted)
        
        
        WebService.postUser(request: SignUpRequest(fullName: fullName,
                                                   email: email,
                                                   password: password,
                                                   document: document,
                                                   phone: phone,
                                                   birthday: birthday,
                                                   gender: gender.index)) { (successResponse, errorResponse) in
            
            if let error = errorResponse {
                
                // Só posso modificar a tela através da Main Thread por isso tenho que fazer o Dispatch
                DispatchQueue.main.async {
                    self.uiState = .error(error.detail)
                }
                
            }
            
            if let success = successResponse {
                
//                WebService.login(request: SignInRequest(email: self.email, password: self.password)) { (successResponse, errorResponse) in
//                    
//                    if let errorSignIn = errorResponse {
//                        
//                        // Só posso modificar a tela através da Main Thread por isso tenho que fazer o Dispatch
//                        DispatchQueue.main.async {
//                            self.uiState = .error(errorSignIn.detail.message)
//                        }
//                        
//                    }
//                    
//                    if let successSignIn = successResponse {
//                        DispatchQueue.main.async {
//                            self.publisher.send(success)
//                            self.uiState = .success
//                        }
//                    }
//                    
//                }
                
            }
            
        }
        
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        //            //self.uiState = .error("Houve um erro no servidor")
        //            self.uiState = .success
        //            self.publisher.send(true)
        //        }
    }
    
}

extension SignUpViewModel {
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}

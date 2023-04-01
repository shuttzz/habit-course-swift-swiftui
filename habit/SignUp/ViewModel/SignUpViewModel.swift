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
    
    private var cancellableSignUp: AnyCancellable?
    private var cancellableSignIn: AnyCancellable?
    
    @Published var uiState: SignUpUIState = .none
    
    private let interactor: SignUpInteractor
    
    init(interector: SignUpInteractor) {
        self.interactor = interector
    }
    
    deinit {
        cancellableSignUp?.cancel()
        cancellableSignIn?.cancel()
    }
    
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
        
        let signUpRequest = SignUpRequest(fullName: fullName,
                                          email: email,
                                          password: password,
                                          document: document,
                                          phone: phone,
                                          birthday: birthday,
                                          gender: gender.index)
        
        cancellableSignUp = interactor.postUser(singUpRequest: signUpRequest)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                // error | finishded
                switch completion {
                    case .failure(let appError):
                        self.uiState = .error(appError.message)
                        break
                    case .finished:
                        break
                }
            } receiveValue: { created in
                if created {
                    
                    self.cancellableSignIn = self.interactor.login(singInRequest: SignInRequest(email: self.email, password: self.password))
                        .receive(on: DispatchQueue.main)
                        .sink { completion in
                            switch completion {
                                case .failure(let appError):
                                    self.uiState = .error(appError.message)
                                    break
                                case .finished:
                                    break
                            }
                        } receiveValue: { successSignIn in
                            print(successSignIn)
                            
                            let auth  = UserAuth(
                                idToken: successSignIn.accessToken,
                                refreshToken: successSignIn.refreshToken,
                                expires: Date().timeIntervalSince1970 + Double(successSignIn.expires),
                                tokenType: successSignIn.tokenType
                            )
                            
                            self.interactor.insertAuth(userAuth: auth)
                            
                            self.publisher.send(created)
                            self.uiState = .success
                        }
                    
                }
            }
        
        
    }
    
}

extension SignUpViewModel {
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}

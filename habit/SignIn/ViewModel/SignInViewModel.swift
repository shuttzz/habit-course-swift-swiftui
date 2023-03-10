//
//  SignInViewModel.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 08/02/23.
//

import SwiftUI
import Combine

class SignInViewModel: ObservableObject {
    
    private var cancellable: AnyCancellable?
    private let publisher = PassthroughSubject<Bool, Never>()
    private let interactor: SignInInteractor
    
    @Published var email = ""
    @Published var password = ""
    
    @Published var uiState: SignInUIState = .none
    
    init(interactor: SignInInteractor) {
        self.interactor = interactor
        cancellable = publisher.sink { value in
            print("Usuário criado! goToHome: \(value)")
            
            if value {
                self.uiState = .goToHomeScreen
            }
        }
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func login() {
        
        self.uiState = .loading
        
        interactor.login(loginRequest: SignInRequest(email: email, password: password)) { (successResponse, errorResponse) in
            
            if let error = errorResponse {
                
                // Só posso modificar a tela através da Main Thread por isso tenho que fazer o Dispatch
                DispatchQueue.main.async {
                    self.uiState = .error(error.detail.message)
                }
                
            }
            
            if let success = successResponse {
                DispatchQueue.main.async {
                    print(success)
                    self.uiState = .goToHomeScreen
                }
            }
            
        }
        
    }
}

extension SignInViewModel {
    func homeView() -> some View {
        return SignInViewRouter.makeHomeView()
    }
    
    func signUpView() -> some View {
        return SignInViewRouter.makeSignUpView(publisher: publisher)
    }
}

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
    private var cancellableRequest: AnyCancellable?
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
        cancellableRequest?.cancel()
    }
    
    func login() {
        
        self.uiState = .loading
        
        cancellableRequest = interactor.login(loginRequest: SignInRequest(email: email, password: password))
            .receive(on: DispatchQueue.main)
            .sink { completion in
                // Aqui no sink é onde acontece o ERRO ou FINISHED
                switch(completion) {
                    case .failure(let appError):
                        self.uiState = .error(appError.message)
                        break
                    case .finished:
                        break
                        
                }
                
            } receiveValue: { success in
                // Aqui é onde acontece o SUCESSO
                self.interactor.insertAuth(
                    userAuth: UserAuth(
                        idToken: success.accessToken,
                        refreshToken: success.refreshToken,
                        expires: Date().timeIntervalSince1970 + Double(success.expires),
                        tokenType: success.tokenType
                    ))
                self.uiState = .goToHomeScreen
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

//
//  SplashViewModel.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 06/02/23.
//

import SwiftUI
import Combine

class SplashViewModel: ObservableObject {
    
    @Published var uiState: SplashUIState = .loading
    
    private var cancellableAuth: AnyCancellable?
    private var cancellableRefresh: AnyCancellable?
    
    private let interactor: SplashInterector
    
    init(interactor: SplashInterector) {
        
        self.interactor = interactor
        
    }
    
    deinit {
        
        cancellableAuth?.cancel()
        cancellableRefresh?.cancel()
        
    }
    
    
    func onAppear() {
        
        cancellableAuth = interactor.fetchAuth()
            .delay(for: .seconds(2), scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .sink { userAuth in
                
                if userAuth == nil {
                    self.uiState = .goToSignInScreen
                } else if (Date().timeIntervalSince1970 > Double(userAuth!.expires)) {
                    let request = RefreshRequest(token: userAuth!.refreshToken)
                    self.cancellableRefresh = self.interactor.refreshToken(refreshRequest: request)
                        .receive(on: DispatchQueue.main)
                        .sink(receiveCompletion: { completion in
                            switch(completion) {
                                case .failure(_):
                                    self.uiState = .goToSignInScreen
                                    break
                                default:
                                    break
                            }
                        }, receiveValue: { success in
                            let auth = UserAuth(
                                idToken: success.accessToken,
                                refreshToken: success.refreshToken,
                                expires: Date().timeIntervalSince1970 + Double(success.expires),
                                tokenType: success.tokenType
                            )
                            
                            self.interactor.inserAuth(userAuth: auth)
                        })
                } else {
                    self.uiState = .goToHomeScreen
                }
                
            }
        
    }
}

extension SplashViewModel {
    
    func signInView() -> some View {
        return SplashViewRouter.makeSignInView()
    }
    
    func homeView() -> some View {
        return SplashViewRouter.makeHomeView()
    }
    
}

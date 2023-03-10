//
//  SplashViewRouter.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 08/02/23.
//

import SwiftUI

enum SplashViewRouter {
    
    static func makeSignInView() -> some View {
        let viewModelSignIn = SignInViewModel(interactor: SignInInteractor())
        return SignInView(viewModel: viewModelSignIn)
    }
    
}

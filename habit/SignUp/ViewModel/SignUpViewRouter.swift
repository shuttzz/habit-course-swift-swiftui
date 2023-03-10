//
//  SignUpViewRouter.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 05/03/23.
//

import SwiftUI

enum SignUpViewRouter {
    
    static func makeHomeView() -> some View {
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
    
}


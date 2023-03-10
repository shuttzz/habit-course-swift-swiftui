//
//  SplashView.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 06/02/23.
//

import SwiftUI

struct SplashView: View {
    
    @ObservedObject var viewModel: SplashViewModel
    
    var body: some View {
        Group {
            switch viewModel.uiState {
                case .loading:
                    loadingView()
                case .goToSignInScreen:
                    viewModel.signInView()
                case .goToHomeScreen:
                    Text("goToHomeScreen")
                case .error(let msg):
                    loadingView(error: msg)
            }
        }.onAppear(perform: viewModel.onAppear)
    }
}

extension SplashView {
    func loadingView(error: String? = nil) -> some View {
        ZStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20)
                .ignoresSafeArea()
            
            if let error = error {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("Habit"), message: Text(error), dismissButton: .default(Text("Ok")) {
                            // Faz algo quando some o alert
                        })
                    }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { value in
            let viewModel = SplashViewModel()
            SplashView(viewModel: viewModel)
                .preferredColorScheme(value)
        }
    }
}

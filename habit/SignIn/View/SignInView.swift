//
//  SignInView.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 08/02/23.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel: SignInViewModel
    
    @State var action: Int? = 0
    
    @State var navigationHidden = true
    
    var body: some View {
        ZStack {
            if case SignInUIState.goToHomeScreen = viewModel.uiState {
                viewModel.homeView()
            } else {
                NavigationView {
                    ScrollView(showsIndicators: false) {
                        
                        // Essa nova VStack vai servir para centralizar o conteudo
                        VStack(alignment: .center, spacing: 20) {
                            
                            Spacer(minLength: 36)
                            
                            VStack(alignment: .center, spacing: 8) {
                                Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.horizontal, 48)
                                
                                Text("Login")
                                    .foregroundColor(.orange)
                                    .font(Font.system(.title).bold())
                                    .padding(.bottom, 8)
                                
                                emailField
                                
                                passwordField
                                
                                enterButton
                                
                                registerLink
                                
                                Text("Copyright - BadBit Tecnologia LTDA 2019")
                                    .foregroundColor(Color.gray)
                                    .font(Font.system(size: 13).bold())
                                    .padding(.top, 16)
                            }
                            
                        }
                        
                        
                        if case SignInUIState.error(let value) = viewModel.uiState {
                            Text("")
                                .alert(isPresented: .constant(true)) {
                                    Alert(
                                        title: Text("Habit"),
                                        message: Text(value),
                                        dismissButton: .default(Text("OK")))
                                }
                        }
                        
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.horizontal, 32)
                        .navigationBarTitle("Login", displayMode: .inline)
                        .navigationBarHidden(navigationHidden)
                }
                .onAppear {
                    self.navigationHidden = true
                }
                .onDisappear {
                    self.navigationHidden = false
                }
            }
        }
        
    }
}

extension SignInView {
    var emailField: some View {
        EditTextView(
            text: $viewModel.email,
            placeholder: "E-mail",
            keyboard: .emailAddress,
            error: "e-mail inválido",
            failure: !viewModel.email.isEmail()
        )
    }
}

extension SignInView {
    var passwordField: some View {
        EditTextView(text: $viewModel.password, placeholder: "Senha", isSecure: true)
    }
}

extension SignInView {
    var enterButton: some View {
        LoadingButtonView(
            action: {
                viewModel.login()
            },
            text: "Entrar",
            showProgress: viewModel.uiState == SignInUIState.loading,
            disabled: !viewModel.email.isEmail() || viewModel.email.isEmpty || viewModel.password.isEmpty
        )
    }
}

extension SignInView {
    var registerLink: some View {
        VStack {
            Text("Ainda não possui um login ativo?")
                .foregroundColor(.gray)
                .padding(.top, 48)
            
            ZStack {
                NavigationLink(
                    destination: viewModel.signUpView(),
                    tag: 1,
                    selection: $action,
                    label: { EmptyView() }
                )
                
                Button("Realize seu Cadastro") {
                    self.action = 1
                }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { value in
            let viewModel = SignInViewModel(interactor: SignInInteractor())
            SignInView(viewModel: viewModel)
                .preferredColorScheme(value)
        }
    }
}

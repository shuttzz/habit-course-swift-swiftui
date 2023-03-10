//
//  SignUpView.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 04/03/23.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel: SignUpViewModel
    
    var body: some View {
        
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center) {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("Cadastro")
                            .foregroundColor(Color("textColor"))
                            .font(Font.system(.title).bold())
                            .padding(.bottom, 8)
                        
                        fullNameField
                        
                        emailField
                        
                        passwordField
                        
                        documentField
                        
                        phoneField
                        
                        birthdayField
                        
                        genderField
                        
                        saveButton
                    }
                    
                    Spacer()
                    
                }.padding(.horizontal, 8)
            }.padding()
            
            if case SignUpUIState.error(let value) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(
                            title: Text("Habit"),
                            message: Text(value),
                            dismissButton: .default(Text("OK")))
                    }
            }
        }
        
    }
}

extension SignUpView {
    var fullNameField: some View {
        EditTextView(
            text: $viewModel.fullName,
            placeholder: "Nome*",
            keyboard: .namePhonePad,
            error: "nome inválido",
            failure: viewModel.fullName.count < 5
        )
    }
}

extension SignUpView {
    var emailField: some View {
        EditTextView(
            text: $viewModel.email,
            placeholder: "E-mail*",
            keyboard: .emailAddress,
            error: "e-mail inválido",
            failure: !viewModel.email.isEmail()
        )
    }
}

extension SignUpView {
    var passwordField: some View {
        EditTextView(
            text: $viewModel.password,
            placeholder: "Senha*",
            error: "senha inválida",
            failure: viewModel.password.count < 8,
            isSecure: true
        )
    }
}

extension SignUpView {
    var documentField: some View {
        EditTextView(
            text: $viewModel.document,
            placeholder: "CPF*",
            keyboard: .numberPad,
            error: "CPF inválido",
            failure: viewModel.document.count < 8
        )
        
        // TODO: mask
        // TODO: isDisabled in edit mode
    }
}

extension SignUpView {
    var phoneField: some View {
        EditTextView(
            text: $viewModel.phone,
            placeholder: "Celular*",
            keyboard: .numberPad,
            error: "Entre com o DDD + 9 dígitos",
            failure: viewModel.phone.count < 10 || viewModel.phone.count >= 12
        )
        
        // TODO: mask
    }
}

extension SignUpView {
    var birthdayField: some View {
        EditTextView(
            text: $viewModel.birthday,
            placeholder: "Data Nascimento*",
            keyboard: .default,
            error: "Data deve ser dd/MM/yyyy",
            failure: viewModel.birthday.count != 10
        )
        
        // TODO: mask
    }
}

extension SignUpView {
    var genderField: some View {
        Picker("Gender", selection: $viewModel.gender) {
            ForEach(Gender.allCases, id: \.self) { value in
                Text(value.rawValue).tag(value)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.top, 16)
        .padding(.bottom, 32)
    }
}

extension SignUpView {
    var saveButton: some View {
        LoadingButtonView(
            action: {
                viewModel.signUp()
            },
            text: "Salvar",
            showProgress: viewModel.uiState == SignUpUIState.loading,
            disabled: !viewModel.email.isEmail() ||
            viewModel.email.isEmpty ||
            viewModel.password.isEmpty ||
            viewModel.fullName.count < 5 ||
            viewModel.document.count < 11 ||
            viewModel.phone.count < 10 ||
            viewModel.phone.count >= 12 ||
            viewModel.birthday.count != 10
        )
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { value in
            
            let viewModel = SignUpViewModel()
            SignUpView(viewModel: viewModel)
                .preferredColorScheme(value)
            
        }
    }
}
